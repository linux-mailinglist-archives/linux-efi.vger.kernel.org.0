Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C494EDB84
	for <lists+linux-efi@lfdr.de>; Thu, 31 Mar 2022 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbiCaOP2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 31 Mar 2022 10:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiCaOP2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 31 Mar 2022 10:15:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BD3574B0;
        Thu, 31 Mar 2022 07:13:41 -0700 (PDT)
Date:   Thu, 31 Mar 2022 16:13:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648736019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMhIRQ0xWSJpAGh/coYpNQk8cKnXciC/JnnLF8sKvnA=;
        b=xGpofyfiezfohp8EQL3jWH94+4POJ5XYSRBjUVA6AynoSoubS+iwuOWvbGNfYYPSZpYKbp
        xdjtlWP7qq2bNOnQlT1vxJPbgXCLqrB4N+oqET80F2D5FSmEIJb7ergkxPdCF8uO2ZVbNt
        ERkJ2U1xizaWvyAnxQUFL6S+Q9E5MHABxsonnxcto3JjJ1AcG8b7ue+vG5A/rdnijND8/p
        tJknswrfD0Wy8awRdJmSQd9sJr/Hr7VbOiZ5dFxNC0AAceHSZRxNlYUNVqI8Urx6SpWP7w
        pk2SvCUrylVGMOfJ5mPcBOTKHLb2+DfjwlaIb62HIJsfJ69VJqVjp7rN0dId0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648736019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MMhIRQ0xWSJpAGh/coYpNQk8cKnXciC/JnnLF8sKvnA=;
        b=wg2aOequgHj21AoyZySMly8GueCSgtBKREc2s3wpW2I1vvbX4p32fuqftN7LQHwrbk/gUs
        epx+D+V02EzteTAQ==
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
Message-ID: <YkW3EmURxE1+kOu5@linutronix.de>
References: <20220331141038.171204-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220331141038.171204-1-javierm@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2022-03-31 16:10:38 [+0200], Javier Martinez Canillas wrote:
> Commit d9f283ae71af ("efi: Disable runtime services on RT") disabled EFI
> runtime services when the CONFIG_PREEMPT_RT option is enabled.
> 
> The rationale for the change is that some EFI calls could take too much
> time, leading to large latencies which are an issue for RT kernels.
> 
> But a side effect of that commit is that now is not possible anymore to
> enable the EFI runtime services by default when CONFIG_PREEMPT_RT is set
> to y, even for platforms that could guarantee bounded time for EFI calls.
> 
> Instead, let's add a new EFI_DISABLE_RUNTIME boolean Kconfig option, that
> would be set to n by default but to y if CONFIG_PREEMPT_RT is enabled.
> 
> That way, the current behaviour is preserved but gives users a mechanism
> to enable the EFI runtimes services in their kernels if that is required.

Is the command line switch
	efi=runtime

not working?

Sebastian
