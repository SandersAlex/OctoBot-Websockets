import asyncio

import pytest

from octobot_websockets.constants import L2_BOOK, TRADES
from octobot_websockets.feeds.bitmex import Bitmex
from octobot_websockets.callback import TradeCallback, BookCallback

pytestmark = pytest.mark.asyncio

test_book = False
test_trade = False


async def book(feed, symbol, asks, bids, timestamp):
    global test_book
    test_book = True


async def trade(feed, symbol, side, amount, price, timestamp):
    global test_trade
    test_trade = True


async def test_bitmex_ticker():
    b = Bitmex(pairs=['BTC/USD'], channels=[TRADES, L2_BOOK], callbacks={
        TRADES: TradeCallback(trade),
        L2_BOOK: BookCallback(book)
    }, create_loop=False)
    b.start()
    await asyncio.sleep(5)
    assert test_book
    assert test_trade
    b.close()
