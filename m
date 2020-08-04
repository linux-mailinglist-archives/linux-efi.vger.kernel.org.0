Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E71223BB03
	for <lists+linux-efi@lfdr.de>; Tue,  4 Aug 2020 15:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgHDNTu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 4 Aug 2020 09:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728605AbgHDNTq (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 4 Aug 2020 09:19:46 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF763207FC;
        Tue,  4 Aug 2020 13:19:43 +0000 (UTC)
Date:   Tue, 4 Aug 2020 14:19:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Elena Petrova <lenaptr@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH v2 3/5] kasan, arm64: don't instrument functions that
 enable kasan
Message-ID: <20200804131939.GC31076@gaia>
References: <cover.1596544734.git.andreyknvl@google.com>
 <26fb6165a17abcf61222eda5184c030fb6b133d1.1596544734.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26fb6165a17abcf61222eda5184c030fb6b133d1.1596544734.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 04, 2020 at 02:41:26PM +0200, Andrey Konovalov wrote:
> This patch prepares Software Tag-Based KASAN for stack tagging support.
> 
> With stack tagging enabled, KASAN tags stack variable in each function
> in its prologue. In start_kernel() stack variables get tagged before KASAN
> is enabled via setup_arch()->kasan_init(). As the result the tags for
> start_kernel()'s stack variables end up in the temporary shadow memory.
> Later when KASAN gets enabled, switched to normal shadow, and starts
> checking tags, this leads to false-positive reports, as proper tags are
> missing in normal shadow.
> 
> Disable KASAN instrumentation for start_kernel(). Also disable it for
> arm64's setup_arch() as a precaution (it doesn't have any stack variables
> right now).
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

I thought I acked this already. Either way:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
