Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BB7662344
	for <lists+linux-efi@lfdr.de>; Mon,  9 Jan 2023 11:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjAIKih (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Jan 2023 05:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjAIKie (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Jan 2023 05:38:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE23C17891
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 02:38:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C23AB80D6E
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 10:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B580EC433D2;
        Mon,  9 Jan 2023 10:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673260711;
        bh=W9pelfN1J1+NxrDkdq4AjUwjRODipX6fJSEy+FDAMw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdx2hd5Pdg+qd8lzFyHayLkvjikk7emJFNd9OGraLCjqYMoxK2tux4zc9pOP/8RXz
         yvGZVR5C/YuV7YF19ANF4yFFmE7z8uYuOB6OXKNbh4byVMAMFdy5syz+/b1KmVTIzj
         xT4Qk4Oal6BemeJSQd2H1W5V8apTEgWS7rrVFgyHnITc7TZfECoTzF9iPXCvwXGf8T
         LdlBMwnHbz01cPSfnClXb1+vjnHVk45AhcvQzRoVraGw3wG/YXAQ9EKjI6sdX5ttZk
         nRPZIRP9y27lF0dKz2RsZnh3P29WVBXIyaBUf+8t6HarRz8SINdmD8OqOHoR3tDvwB
         gQuU42LJ4bazQ==
Date:   Mon, 9 Jan 2023 10:38:25 +0000
From:   Lee Jones <lee@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 0/2] efi: Follow-up fixes for EFI runtime stack
Message-ID: <Y7vuobjqmoyT+MPB@google.com>
References: <20230106174703.1883495-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230106174703.1883495-1-ardb@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 06 Jan 2023, Ard Biesheuvel wrote:

> Commit ff7a167961d1b ("arm64: efi: Execute runtime services from a
> dedicated stack") introduced a dedicated stack for EFI runtime services,
> in an attempt to make the execution of EFI runtime services more robust,
> given that they execute at the same privilege level as the kernel.
> 
> However, this stack needs to be declared to the stacktrace machinery,
> which is careful not to walk the stack when it leads into memory regions
> that are not known to be allocated for stack use.
> 
> Also, given that the ACPI code may invoke the low-level EFI runtime call
> wrapper without using the dedicated kernel thread and workqueue, we
> should take this into account when trying to gracefully handle
> synchronous exceptions.
> 
> Changes since v2:
> - clear efi_rt_stack_top[-1] from asm code, and use READ_ONCE() to read
>   its value when not holding the spinlock, to ensure that all accesses
>   are safe under concurrency;
> - add Mark's ack to patch #2
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Lee Jones <lee@kernel.org>
> 
> Ard Biesheuvel (2):
>   arm64: efi: Avoid workqueue to check whether EFI runtime is live
>   arm64: efi: Account for the EFI runtime stack in stack unwinder

Should either / both of these be routed to Stable?

If so, we should probably Cc: them.

>  arch/arm64/include/asm/efi.h        |  9 +++++++++
>  arch/arm64/include/asm/stacktrace.h | 15 +++++++++++++++
>  arch/arm64/kernel/efi-rt-wrapper.S  |  6 ++++++
>  arch/arm64/kernel/efi.c             |  3 ++-
>  arch/arm64/kernel/stacktrace.c      | 12 ++++++++++++
>  5 files changed, 44 insertions(+), 1 deletion(-)
> 
> -- 
> 2.39.0
> 

-- 
Lee Jones [李琼斯]
