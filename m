Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3A4EDBD7
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237671AbiCaOmF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbiCaOmF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 10:42:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16F847059;
        Thu, 31 Mar 2022 07:40:17 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:40:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648737616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+IkG3JW9hEB4tEEqML5Y6wrmDVIsuesXsPzmJPiIrNI=;
        b=oshonStWF9r60qtMFyluGUDngunvGElNNX9iTQobTXOjrOsZkcbq/vqSLOAC0XsO/4yx51
        JpdlpNxoHRr+KIXxI9Q4Ps0o7Cd4ENBpmbq4x3L1o7RSqK4KPqTPdA58muyZMJWa3/3C4+
        UHtpLyFoRZvneejIV70GgLXt/4nVQrDKTJtKH0te0xdnj3wH8jQRwNtSqXWG4bDygykPXd
        5pIVLJcL+/i4EwlvU9Le+kV+g1x+OfaYKEF16R6z7TL9nA35EHKLLguN1HAWoaTz1/2OJL
        86flawMjVsAtvrUcL3q4e6y8i55MSX2EVs7nY2VG1YLrybyc83aOt6y9bg6Rsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648737616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+IkG3JW9hEB4tEEqML5Y6wrmDVIsuesXsPzmJPiIrNI=;
        b=A9HFrj211R6RwlbLVgi1gfqL/evVkf8fu8kMvbp0MbqlrW1CVmzJwYrEA54gic96TpT2VK
        nK7AWjmOZd87g0Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Al Stone <ahs3@redhat.com>, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        linux-rt-users@vger.kernel.org, Brian Masney <bmasney@redhat.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] efi: Allow to enable EFI runtime services with PREEMPT_RT
Message-ID: <YkW9T2xRSI9e4BFv@linutronix.de>
References: <20220331141038.171204-1-javierm@redhat.com>
 <YkW3EmURxE1+kOu5@linutronix.de>
 <ce8d975e-d9dd-f9b8-793d-234258021169@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ce8d975e-d9dd-f9b8-793d-234258021169@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-03-31 16:25:40 [+0200], Javier Martinez Canillas wrote:
> Hello Sebastian,
Hi Javier,

> Yes, it is but the motivation is to be able to have EFI runtime services
> by default without the need for any kernel command line parameter.

This part wasn't clear. It is not mentioned by the description but now
that I look at Kconfig, it is there.

> In the same vein, I could ask if efi=noruntime wasn't enough instead of
> commit ("efi: Disable runtime services on RT").

No, it is not because it should not lead to any surprise latencies by
default.

Sebastian
