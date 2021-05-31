Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B22E395A3F
	for <lists+linux-efi@lfdr.de>; Mon, 31 May 2021 14:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhEaMQy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 31 May 2021 08:16:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231409AbhEaMQy (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 31 May 2021 08:16:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5A7E611CB;
        Mon, 31 May 2021 12:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622463313;
        bh=NsxGklFVBPtRLEgHmYwehRv754CyKWtrob2WOdC4Wmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aJ9dMSkPFE2/otWmVIOdpbB0uQU+7jCXuVjJV12NtEDuPvw/9JC7fPPpz9eoEHsM6
         KSGl1IaWyhD1fLmHX4XFe+E70mgb3biV5M//xh8XYYXrBuVGHhD7YUZlY3BBWHOM4Z
         xdsq81VKvQnBjYNiFCcXZ/DSh91HN8ONfqh+p+Os5ml+/lLcLNE/MQnDgEdP89ZSTD
         3oHu1ZVWld9iK2zMJ6BPxAKyPLu5vAka5Wta1NXZNxylK6jR7dIzR8NaXsMCQqTCUd
         XRu+cA33E91g67ktCoLeXW41TrBN0MRfDKOQ1s3rsJne20PoIwkcD8coBmweKHfuKz
         asly++Zc/XJLA==
Date:   Mon, 31 May 2021 15:15:03 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, kexec@lists.infradead.org,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@amacapital.net, bhe@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v2] x86/efi: unconditionally hold the whole low-1MB
 memory regions
Message-ID: <YLTTR5bpOv3XNu32@kernel.org>
References: <20210531090023.16471-1-lijiang@redhat.com>
 <YLSnkKeoQnokXVsK@zn.tnic>
 <YLSzUBQ/7CyINu87@kernel.org>
 <YLS/1sqz6Bncg5VU@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLS/1sqz6Bncg5VU@zn.tnic>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 31, 2021 at 12:52:06PM +0200, Borislav Petkov wrote:
> On Mon, May 31, 2021 at 12:58:40PM +0300, Mike Rapoport wrote:
> > Right, but TBH, I didn't update efi_free_boot_services() in my initial
> > version. I've added similar change there now and I'm waiting now to see if
> > kbuild is happy with this:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=x86/reservelow
> 
> Right, also I'm guessing that first patch should be
> 
> Cc: <stable@vger.kernel.org>
> 
> as there was one report with failing boot, right?

Hmm, why?
The regression is from v5.13-rc1, isn't it?

-- 
Sincerely yours,
Mike.
