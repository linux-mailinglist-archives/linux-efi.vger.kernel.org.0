Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3363541B20B
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 16:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbhI1O0Q (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 10:26:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240960AbhI1O0Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 10:26:16 -0400
Date:   Tue, 28 Sep 2021 16:24:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632839075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nWO/auxSHRfRWpNEL7Md5kMBOjo28ZBmKHwz1FV9Mjg=;
        b=fyyN2RI1thGBQm4a8q9/sWzDNDSrkft2gIpINgYhBEwezUvAgxkmmZsdJNukhBV2Ud5KMB
        dkonZ/iW0mwYeiicCqUpI2nG4rzHGzmBhXCGxZXxDYcfI2CzELr/y9bBxfHQ2+YJpG1XK2
        QPTy6eueIwBbXeHqYy3FNoPW55Uag7q3o+Nc7Te+A5dX4ULBiC29mzz3syRGtPuqsMni5u
        VTEsiwaBmjR+irkuWY51a5pIHg/jFX2aAuKew8E0GFAnL1SnHwcVQL0BLI7ey+JXkZtcIX
        MEuDcBJpBEh6IZQpRZXpU2ZUC65AolGqy10ag6EHqyy3otjNJ0d6xPVrdWkZGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632839075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nWO/auxSHRfRWpNEL7Md5kMBOjo28ZBmKHwz1FV9Mjg=;
        b=Iq2pEujzO/8eyAjouJlxXzLuXzmXA2/PjuIwRWmqkrjLTktksHeC6S6z6D8J1ZT9ivFJvT
        t7igIM2wrRog00AQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
Message-ID: <20210928142434.uqhkd3ribja6j654@linutronix.de>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de>
 <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de>
 <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-09-28 15:34:47 [+0200], Ard Biesheuvel wrote:
> Are you sure you want to disable EFI runtime services on all x86
> systems with PREEMPT_RT as well?

The only problem that I am aware of is that you need to reboot with
enabled runtime service (via bootargs, #2) in order to alter boot loader
settings.
I'm not aware of any other shortcomings. There are no guarantees how
long an EFI service routine may take.
That patch is in the RT queue since v4.18-rc8-rt1.

Sebastian
