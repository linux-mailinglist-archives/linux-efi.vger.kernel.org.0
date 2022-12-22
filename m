Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BF26540DB
	for <lists+linux-efi@lfdr.de>; Thu, 22 Dec 2022 13:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiLVMPL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Dec 2022 07:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235302AbiLVMOr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Dec 2022 07:14:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E08411A33
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 04:10:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 228F9B81D11
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 12:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E50C433F0
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 12:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671711025;
        bh=E68QJ5u84egVn0rRD6mm8rDox5KCLsp0fcur4taeJLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PnvKAHBD43MgHkK+4V9Q3wCC3Run6OozR3S+QCgwifxwXpJNgLixkL+88cqkSkTpg
         /T/JygC4NsjhSAki+PrdoMktKl2FBMkvsDQhzuOYWaFI1n1fNNZ90Rwf3bwabzRHMc
         iZv7OKB1JB2L4RODz1CDnXW8JYxLjtiPvYZSXiR+eP1sUf6rRINM1VEch2DwQ9dWAG
         B1/xYIhm6E8SQC7J1aHxsQaPcDqWFVM2BdZs/ovGASpGUopZXOVxc8r8iTl7+PMEbv
         HcyKWeoNtGqYNFoFQuhPV6jSrhx83FTRpFo9QAqNA91ov6pRpP04zYVKnxN0XlQrFn
         C0rqrln1lnLzw==
Received: by mail-lf1-f43.google.com with SMTP id b13so2459241lfo.3
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 04:10:25 -0800 (PST)
X-Gm-Message-State: AFqh2koPVNrN9NKhpYGJqgsjOB0QYWKt3d1ksSduPeUQk6DXxngyG+Jb
        MeevqkhGw8rsxs4fDYx26VgeW8IlabpiWZg54Uc=
X-Google-Smtp-Source: AMrXdXt2baZe9C0VPXzXbHdn79G85P7pKhpu2kUnNa2xQpfnVeZydZQF8wz9tK4fh1qbdJ9FmDa1IEuHtd3b3Y/IyLE=
X-Received: by 2002:a05:6512:3d93:b0:4b8:9001:a694 with SMTP id
 k19-20020a0565123d9300b004b89001a694mr314489lfv.426.1671711023846; Thu, 22
 Dec 2022 04:10:23 -0800 (PST)
MIME-Version: 1.0
References: <CALu+AoSXOCJPH0edbb-BmyTz2zUywY8-QfjYjjKJggSTmK=WyQ@mail.gmail.com>
 <bfd82c75c5a387a0cad0da4ebe6e9d4c87ca7ac0.camel@HansenPartnership.com>
In-Reply-To: <bfd82c75c5a387a0cad0da4ebe6e9d4c87ca7ac0.camel@HansenPartnership.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Dec 2022 13:10:12 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHO1mrhtu7woF8veEgDJobj3eV-cFxZNnZKcqyENmX5LA@mail.gmail.com>
Message-ID: <CAMj1kXHO1mrhtu7woF8veEgDJobj3eV-cFxZNnZKcqyENmX5LA@mail.gmail.com>
Subject: Re: Queries about disabling EFI runtime services late
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-efi@vger.kernel.org,
        Coiby Xu <coxu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Dec 2022 at 16:04, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2022-12-20 at 11:43 +0800, Dave Young wrote:
> > Hi Ard,
> >
> > Real time kernels usually disable efi runtime for latency issues,
>
> Could you say a bit more about this?  I was under the impression we
> only call efi runtime services when asked: for variable or capsule
> updates or if you use the EFI RTC.  So if you don't use EFI services in
> a real time kernel, you shouldn't suffer any latency issues due to
> having them enabled.
>
> >  but for some use cases, e.g. when Secure Boot is used kexec needs to
> > get the UEFI keys to verify the kernel signatures with
> > kexec_file_load syscall.
>
> It's not just kexec.  Without EFI variable services, you won't be able
> to update the MoK keys for new kernels either.
>

I think it is a mistake to disable EFI runtime services on RT kernels.
As you both have pointed out, this results in a loss of functionality
already, but we have recently introduced ACPI PRMT, which is a
replacement for SMM based 'invisible' OEM code, where platform
firmware routines invoked by the ACPI AML code are dispatched in the
same way as EFI runtime services.

As I understand it, there are two reasons for this choice:
- EFI runtime services disable preemption
- EFI runtime services are permitted to en/disable interrupts temporarily

I should point out that the situation has already improved
substantially, given that since a couple of years, we no longer keep
interrupts disabled at the kernel level while any runtime service is
in progress. Given the lack of reported regressions in that time
frame, I think we can conclude that running with interrupts enabled is
fine.

This also means that disabling migration should be sufficient, and
disabling preemption is unnecessary, as apparently, the firmware code
can generally code with being interrupted, and the firmware does not
have any insight into whether it is being interrupted by code running
in hardirq, softirq or task context.

So that leaves the firmware code's ability to en/disable interrupts
altogether. There is nothing we can do about that, but as James points
out, the EFI runtime services are basically opt-in already, and you
are free not to invoke them (there are some exceptions here - there
are some drivers that perform a getvariable() call at bind time iirc).
The ACPI PRMT code is platform specific though, but I don't think you
can run an RT kernel on those systems in the first place.

In summary, I think we should make the firmware calling infrastructure
play more nicely with RT, by switching to migrate_disable(), and
reassess whether or not they must still be disabled at all times on
such kernels.
