Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26564434521
	for <lists+linux-efi@lfdr.de>; Wed, 20 Oct 2021 08:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTGbI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Oct 2021 02:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTGbH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Oct 2021 02:31:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61B7C06161C
        for <linux-efi@vger.kernel.org>; Tue, 19 Oct 2021 23:28:53 -0700 (PDT)
Date:   Wed, 20 Oct 2021 08:28:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634711331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ONMbJ4fxECIMEdtMhfpwODwaZp4eWmvVz/rQM5VLfU=;
        b=lwvLrz3oqR4Q6zgicpxqM/qURy0NvMIpeo2AJG8hyOjkopmWo2I4MGeJeJ0X/gtR8TN37O
        KhrFAlPP/9hMdY3jeuO/oq3Cbf8O4Cm+cZzkYSUEK2oGLtMtpvk68kKHnPJBMSoWRZhChF
        vnYN8YFRHQ3jgMfYWuT8vfFqWVPx4lv34sSNSXnVz4g3S7Tpbt4aK5NHAN1G1qgaWarpot
        8o99tL1i9970Gwovqgekczx4AFh+XmjpC498vDrJ65Zt+aDiHsp8piDaSpoyoQuowrJuF9
        J/y/Yo/4ehEy/ZK5KJ9mtokhPLgeshiRNWC2cxrEWmzhZLUzIbFhgRaZMORD0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634711331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0ONMbJ4fxECIMEdtMhfpwODwaZp4eWmvVz/rQM5VLfU=;
        b=kCugfiwmK6lR+20diMAPoLx4wCWKwerrvvm3zQPf8+PiSUAtnjheyS62RDlwEfLUijhgek
        yko+NS4mS5rbyrBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     joeyli <jlee@suse.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
Message-ID: <20211020062850.3wvw7lqauh6pzfd2@linutronix.de>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de>
 <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de>
 <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
 <20210928142434.uqhkd3ribja6j654@linutronix.de>
 <20211020060955.GC3965@linux-l9pv.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020060955.GC3965@linux-l9pv.suse>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-10-20 14:09:55 [+0800], joeyli wrote:
> On Tue, Sep 28, 2021 at 04:24:34PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2021-09-28 15:34:47 [+0200], Ard Biesheuvel wrote:
> > > Are you sure you want to disable EFI runtime services on all x86
> > > systems with PREEMPT_RT as well?
> > 
> > The only problem that I am aware of is that you need to reboot with
> > enabled runtime service (via bootargs, #2) in order to alter boot loader
> > settings.
> 
> Just provide another case:
> Anyone who uses mokutil for enrolling MOK will also need reboot with
> efi=runtime first.

I have no idea what it does. This enrolling is only required once
per-lifetime and not on each system boot, right?

> Joey Lee

Sebastian
