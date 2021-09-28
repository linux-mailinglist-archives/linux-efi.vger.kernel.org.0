Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA54641B84D
	for <lists+linux-efi@lfdr.de>; Tue, 28 Sep 2021 22:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242724AbhI1UaJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Sep 2021 16:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbhI1UaI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Sep 2021 16:30:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B7DC06161C
        for <linux-efi@vger.kernel.org>; Tue, 28 Sep 2021 13:28:29 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632860907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJqu5/StzOaQ0WVlLeYP47uh7BKNBhkFRr164Dujha0=;
        b=OzOAveG6MstssmvS0XD9onvjnDouAwYYw8Ybp+LcsbQLQ/J/iwhG+XZfQxtX/D58XzsTKo
        qpkVSQK4QSW/r10DxQNj814vnbhY7azIMgsgnUNldyqZU706HI/TXRe6PZbBqUcUM/hMFr
        xtA4mZ/f8b9F1UWi9qNGcJbr4kqJKnQPOE5HAy47xiiwwKjBuI4wV36P5kZfMDH3iZsDO/
        bH21HxQzeJkry+iUOy64SBbxToC9jVtOiq1Qh1v57pFgQ95Dq5MLlmz9TsD6lN0SBY0P39
        ajqZ+MPP+4sJxDPP/g0Rm7hLhAlA8KAZ5C1Jfa/ZHBKD8XJW9sMHnlsn4CDzNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632860907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QJqu5/StzOaQ0WVlLeYP47uh7BKNBhkFRr164Dujha0=;
        b=1PzJ2uLe323HTiwwXDAeshvrfL0O3z/9y4xRmjtA5kpxkMDDUAyiZJvSon4ANMduQ/k22Q
        Vl/3cB2+7ToEZIDw==
To:     Ard Biesheuvel <ardb@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 1/2] efi: Disable runtime services on RT
In-Reply-To: <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
References: <20210924134919.1913476-1-bigeasy@linutronix.de>
 <20210924134919.1913476-2-bigeasy@linutronix.de>
 <CAMj1kXFJm-su9tc20n+DyJjMwrhK6R4BR0Kd_ov62NqXd-jwUw@mail.gmail.com>
 <20210928133340.tmpjzdj367h54ddt@linutronix.de>
 <CAMj1kXG5-i5LqnQrjK79KWZYTPO4C4fF32KhQexj8WsHLQM_Lg@mail.gmail.com>
Date:   Tue, 28 Sep 2021 22:28:27 +0200
Message-ID: <87k0j0a1hw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Ard,

On Tue, Sep 28 2021 at 15:34, Ard Biesheuvel wrote:
> On Tue, 28 Sept 2021 at 15:33, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>>
>> On 2021-09-28 15:30:32 [+0200], Ard Biesheuvel wrote:
>> > This is generic code and the commit log only talks about arm64. How
>> > about other architectures?
>>
>> They also invoke the EFI services with disables interrupts. If they
>> provide a RTC behind spi/i2c then we end up in the same situation right?
>> Or did I misunderstand your point?
>>
> Are you sure you want to disable EFI runtime services on all x86
> systems with PREEMPT_RT as well?

I'm pretty sure because we've ran into inacceptable latencies with EFI
runtime services often enough.

Since we disabled them these complaints have gone down to 0 and nobody
so far complained about their non-availability.

We might revisit that and make them default disabled on RT and offer a
command line option to enable them for those who really want them.

Thanks,

        tglx
