Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F394345D1
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 09:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhJTHWd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 03:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhJTHW2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 03:22:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BA9C06161C
        for <linux-efi@vger.kernel.org>; Wed, 20 Oct 2021 00:20:15 -0700 (PDT)
Date:   Wed, 20 Oct 2021 09:20:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634714413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/kE9PFQPlqZV7anuuov0NTGmumKwJjFltt7KNbzvZ4=;
        b=zoaCgdPEbKQWw9WfvEOXEuqltoJHSSjDGe/vQs1fFWjao9PuGr+mLntqY1hVgiOpKkFPO4
        6d/64q1b3bwAg2JZKU8VENMWTGhuxjH2H6tmnkXPVioUsApewLikrraWJoWtrpH8/mVrsO
        erwxBvUFvSt2AJbFZYz+o5DlzsgS3DAjKyXMl+fAiVIkTxMQce055kr5hrXQJxLlg6vxj9
        djoUjXDtMJJfSrcDQoAW9XN57oN7pptgq+4NyuDuGaQuKdcaqGTibztZWBUFuPXO+ywCXB
        9wGv0Udal/h7H897gqwk/ivgukU4GdyPt9acD7u9H7AHRgstfgMxo2reLmEDhQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634714413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/kE9PFQPlqZV7anuuov0NTGmumKwJjFltt7KNbzvZ4=;
        b=9OWOKv7FfDdOu9CGcwY+qsy/zeYF4ZrXR8OseqXOZXSnBHTLFcER+a1gJrV07CSLpV5HBo
        Wkwp9npgPghu19Cw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     joeyli <jlee@suse.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
Message-ID: <20211020072012.wvqerq4xeafqldnd@linutronix.de>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de>
 <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de>
 <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
 <20210928142434.uqhkd3ribja6j654@linutronix.de>
 <20211020060955.GC3965@linux-l9pv.suse>
 <20211020062850.3wvw7lqauh6pzfd2@linutronix.de>
 <20211020064718.GD3965@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020064718.GD3965@linux-l9pv.suse>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-10-20 14:47:18 [+0800], joeyli wrote:
> > I have no idea what it does. This enrolling is only required once
> > per-lifetime and not on each system boot, right?
> 
> Yes, no each system boot.
> 
> But when boot loader or kernel be updated or user wants to install a
> self-signed kernel or module. Then they need to reboot with efi=runtime
> in the future.

I see.

> On the other hand, any RT distro that suppors MOK needs to modify their
> installation program/process to add efi=runtime in first boot. Otherwise
> the installation will be failed. Honestly this patch changed the kernel
> behavior and it may causes that old installation get problem.

Nope. It was in the -RT queue since v4.18-RT, and I see it backported
into latest v4.14.244-rt121 probably earlier kernels, too.
So unless you ship something pre v4.18-RT without that patch and you
update to post v4.18-RT you need to pay attention - independently of
this being now merged upstream.

This is also in the wiki
   https://wiki.linuxfoundation.org/realtime/documentation/known_limitations#efi

> Joey Lee

Sebastian
