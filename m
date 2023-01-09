Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4F866278F
	for <lists+linux-efi@lfdr.de>; Mon,  9 Jan 2023 14:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjAINqR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Jan 2023 08:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbjAINqQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Jan 2023 08:46:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B56618E2A
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 05:46:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EADA3B80C9C
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 13:46:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EECC433F2
        for <linux-efi@vger.kernel.org>; Mon,  9 Jan 2023 13:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673271973;
        bh=EWIDLHaJ6MtuiTFHAfhWEiMc23gHVVdToeibVDc/oZE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gnTHXFfVBf86Evf0Rjxa+dg8vVKRNvR/3HIUvqQhxPZb5wy+j9mjJ+GJ3muzcR6ES
         Tsj0a+sbvS6l2mUtpbnHFUm3/WXFyWc7Wt/ZxboGvlxnrjB8SVd8q7bsbunqz9YlYT
         PMbazx0k1ErTTaQoGVK1g6hMmDuVgDIob66F+eY00zYTkdq0nMomPmTrr1b9hKgL22
         Ei+AOZkSMJ4/ZWyFned/CC+zQRQMRp7yTpeIwmyiH5LY09B4tzu72bqTdy6fCaB4gh
         XtdghBaAD8cZNFXtHFbpPpEUM7t1E9WaNubzdprSYTk7vntpaGI5fyQLaSltr6vtpg
         idZs8zdbM3c5g==
Received: by mail-lj1-f181.google.com with SMTP id p25so2711828ljn.12
        for <linux-efi@vger.kernel.org>; Mon, 09 Jan 2023 05:46:13 -0800 (PST)
X-Gm-Message-State: AFqh2krkUdKYrpRyYjR1BDo8GPQcK8vBH7unS5CWFvIzVRCZya2A7fWP
        uzG3rQ1LU8DvO5ZE4iFba/YQWrG+ZyFxoj3C9Yo=
X-Google-Smtp-Source: AMrXdXsJRH36wVlbKH5XAq7tjjPJdTC7IeJiT3AoKqNRZOA12PUWXcDFe5Rk3Hs7Vood83vankPCCGnVSmarcP2ziMA=
X-Received: by 2002:a2e:bd0c:0:b0:27f:bc58:3924 with SMTP id
 n12-20020a2ebd0c000000b0027fbc583924mr3929174ljq.352.1673271971656; Mon, 09
 Jan 2023 05:46:11 -0800 (PST)
MIME-Version: 1.0
References: <20230106174703.1883495-1-ardb@kernel.org> <Y7vuobjqmoyT+MPB@google.com>
In-Reply-To: <Y7vuobjqmoyT+MPB@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 9 Jan 2023 14:46:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHUdWBZGZBXfukw++RCr6WpALjw-v1Oazs6JFJ5wP2diA@mail.gmail.com>
Message-ID: <CAMj1kXHUdWBZGZBXfukw++RCr6WpALjw-v1Oazs6JFJ5wP2diA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] efi: Follow-up fixes for EFI runtime stack
To:     Lee Jones <lee@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 9 Jan 2023 at 11:38, Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 06 Jan 2023, Ard Biesheuvel wrote:
>
> > Commit ff7a167961d1b ("arm64: efi: Execute runtime services from a
> > dedicated stack") introduced a dedicated stack for EFI runtime services,
> > in an attempt to make the execution of EFI runtime services more robust,
> > given that they execute at the same privilege level as the kernel.
> >
> > However, this stack needs to be declared to the stacktrace machinery,
> > which is careful not to walk the stack when it leads into memory regions
> > that are not known to be allocated for stack use.
> >
> > Also, given that the ACPI code may invoke the low-level EFI runtime call
> > wrapper without using the dedicated kernel thread and workqueue, we
> > should take this into account when trying to gracefully handle
> > synchronous exceptions.
> >
> > Changes since v2:
> > - clear efi_rt_stack_top[-1] from asm code, and use READ_ONCE() to read
> >   its value when not holding the spinlock, to ensure that all accesses
> >   are safe under concurrency;
> > - add Mark's ack to patch #2
> >
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Lee Jones <lee@kernel.org>
> >
> > Ard Biesheuvel (2):
> >   arm64: efi: Avoid workqueue to check whether EFI runtime is live
> >   arm64: efi: Account for the EFI runtime stack in stack unwinder
>
> Should either / both of these be routed to Stable?
>
> If so, we should probably Cc: them.
>

I'll forward them to -stable by hand once all the bits and pieces land
in Linus's tree.

Feel free to remind in a week or so, though.

Thanks,
Ard.
