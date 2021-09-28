Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313DE41B0F5
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241226AbhI1Nh6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 09:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240958AbhI1Nhq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 09:37:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17DBFC07E5F8
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 06:34:15 -0700 (PDT)
Date:   Tue, 28 Sep 2021 15:33:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632836021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpmKovq3FE6Gpl9zVV4IiHevU78CuTwCY+JFyCrXzlY=;
        b=qOaWTiTYE7Oj12MqiSPCyzPuGG7LdekNn4z8+vAJ88DrTWFq4iF29PLfAZEjXNe7fqheh5
        KVbEHZdBwQX+jZDizrqFYB6DtNVncG7ddcqjVJ2pUmwjN4b3se2YrvtgyiZPMEr+j3DDIA
        Pm5Tey6AWxGA08HMI0bJEnfAoTwpCLGZWhzNyXC0BW//54rE0NUQ5gJEr1tW0rSEmB5MAz
        Hsnp+qI6nhdfnAFDuYG45Iti393JliKiMPE+srrn4l1KbGJNTQUWPQCWBg2dnsFE29iiLW
        u2pkZaAv0crHFgRE5/KtsIX+rjDE796kSGEaTTzxJVuADjeusQkG1euCBq3ewg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632836021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mpmKovq3FE6Gpl9zVV4IiHevU78CuTwCY+JFyCrXzlY=;
        b=qxSKEAFS3WE9YQNRUTGZdpJulW8ae4uZqwuLKAq+eF11gZEfs4K5E6xFkNIA0ScB32KtaL
        agY4yALyrd5Z/mDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
Message-ID: <20210928133340.tmpjzdj367h54ddt@linutronix.de>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de>
 <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-09-28 15:30:32 [+0200], Ard Biesheuvel wrote:
> This is generic code and the commit log only talks about arm64. How
> about other architectures?

They also invoke the EFI services with disables interrupts. If they
provide a RTC behind spi/i2c then we end up in the same situation right?
Or did I misunderstand your point?

Sebastian
