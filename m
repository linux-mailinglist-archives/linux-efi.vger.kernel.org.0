Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEB3654BEE
	for <lists+linux-efi@lfdr.de>; Fri, 23 Dec 2022 05:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiLWEQf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 22 Dec 2022 23:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiLWEQe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 22 Dec 2022 23:16:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF8B5591
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 20:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671768947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZlzjXtVFRVdyVCdlHck1RIv+V/TJTOPa/mytEskP6FQ=;
        b=KkyZxyxRTACqvxCDEGH9I0s9QeX1ACFJUXgSyiSuv0B1RwfG+htxsGA7Em7w36KMBZIpe2
        7rYC/0ADe/mhEYnZcf14AdPj4H3hC7ByAtDaTObYYfmit+7rnpDw9KFHnYVKGWb+ro4wkw
        ufyor6n9DYP232K8UpSCKiHM5I/gud4=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-8-1mCrwkGyPSG8XEXQnlaHrQ-1; Thu, 22 Dec 2022 23:15:46 -0500
X-MC-Unique: 1mCrwkGyPSG8XEXQnlaHrQ-1
Received: by mail-lf1-f69.google.com with SMTP id i13-20020a056512340d00b004b8825890a1so1562486lfr.1
        for <linux-efi@vger.kernel.org>; Thu, 22 Dec 2022 20:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlzjXtVFRVdyVCdlHck1RIv+V/TJTOPa/mytEskP6FQ=;
        b=ayOywET908cSwZY5BaUdg9k55G38FH8bK3AVGO55tkqvGBz71tqSxy7Lsn3dZCMOjJ
         dTb9CTt8zovUZq+aBLz7O5RK4GNMS6eMck5zOYGw2YTwRUy2pzqaU7rrDnO79cQufniA
         ZdaD3N/YKgKCAWt9B8w8Bn4DaId7Be0m0B/LpXXtn6Rq4xwEkwzlxSRhX9j7kFsI31k7
         DW+Jktk+3FmLw/UX/sh0sw9MtYwNoQN1guMbQ1C7/CfqtZjc2PzP/Jc/ODwO/2Wqrg4V
         0YmV732ogYyujgn1LLA3GvEtxNXc/oO1TLtA4PX6EDi5G3THmHincrZRFma3kfQRHhLr
         xuDg==
X-Gm-Message-State: AFqh2kqbse7LCN/7Df6zICU5i2TEzIgo0Fym9T7kJ5JXK0DD/wXRkChi
        /sxlK94F88Vwwe+I25BXf4p2bTup3hU6XqnX2xi9szwSb15MHlcEhkOv0vWAl5UpAF6OMU42ZL2
        Z/QsfwybrXE5yDMKLN8Q/W39xUh38kz5LSKdQ
X-Received: by 2002:a2e:8891:0:b0:27e:a9c4:cc44 with SMTP id k17-20020a2e8891000000b0027ea9c4cc44mr766236lji.477.1671768944348;
        Thu, 22 Dec 2022 20:15:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuX2leEvkt6xJBH1JVu4E5Wfgbae3xXQToSG8NhbsiD2PnxscTSFfW+A2T2Yh9/Evctn+s7a9f5N8MrTDgfgYM=
X-Received: by 2002:a2e:8891:0:b0:27e:a9c4:cc44 with SMTP id
 k17-20020a2e8891000000b0027ea9c4cc44mr766228lji.477.1671768944175; Thu, 22
 Dec 2022 20:15:44 -0800 (PST)
MIME-Version: 1.0
References: <CALu+AoSXOCJPH0edbb-BmyTz2zUywY8-QfjYjjKJggSTmK=WyQ@mail.gmail.com>
 <bfd82c75c5a387a0cad0da4ebe6e9d4c87ca7ac0.camel@HansenPartnership.com> <CAMj1kXHO1mrhtu7woF8veEgDJobj3eV-cFxZNnZKcqyENmX5LA@mail.gmail.com>
In-Reply-To: <CAMj1kXHO1mrhtu7woF8veEgDJobj3eV-cFxZNnZKcqyENmX5LA@mail.gmail.com>
From:   Dave Young <dyoung@redhat.com>
Date:   Fri, 23 Dec 2022 12:14:33 +0800
Message-ID: <CALu+AoTfeqAMxFgz18stHtD6k+Tonr67Eo7H9MWLDDj8_g-b-Q@mail.gmail.com>
Subject: Re: Queries about disabling EFI runtime services late
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-efi@vger.kernel.org, Coiby Xu <coxu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 22 Dec 2022 at 20:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 20 Dec 2022 at 16:04, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> >
> > On Tue, 2022-12-20 at 11:43 +0800, Dave Young wrote:
> > > Hi Ard,
> > >
> > > Real time kernels usually disable efi runtime for latency issues,
> >
> > Could you say a bit more about this?  I was under the impression we
> > only call efi runtime services when asked: for variable or capsule
> > updates or if you use the EFI RTC.  So if you don't use EFI services in
> > a real time kernel, you shouldn't suffer any latency issues due to
> > having them enabled.
> >
> > >  but for some use cases, e.g. when Secure Boot is used kexec needs to
> > > get the UEFI keys to verify the kernel signatures with
> > > kexec_file_load syscall.
> >
> > It's not just kexec.  Without EFI variable services, you won't be able
> > to update the MoK keys for new kernels either.
> >
>
> I think it is a mistake to disable EFI runtime services on RT kernels.
> As you both have pointed out, this results in a loss of functionality
> already, but we have recently introduced ACPI PRMT, which is a
> replacement for SMM based 'invisible' OEM code, where platform
> firmware routines invoked by the ACPI AML code are dispatched in the
> same way as EFI runtime services.
>
> As I understand it, there are two reasons for this choice:
> - EFI runtime services disable preemption
> - EFI runtime services are permitted to en/disable interrupts temporarily
>
> I should point out that the situation has already improved
> substantially, given that since a couple of years, we no longer keep
> interrupts disabled at the kernel level while any runtime service is
> in progress. Given the lack of reported regressions in that time
> frame, I think we can conclude that running with interrupts enabled is
> fine.
>
> This also means that disabling migration should be sufficient, and
> disabling preemption is unnecessary, as apparently, the firmware code
> can generally code with being interrupted, and the firmware does not
> have any insight into whether it is being interrupted by code running
> in hardirq, softirq or task context.
>
> So that leaves the firmware code's ability to en/disable interrupts
> altogether. There is nothing we can do about that, but as James points
> out, the EFI runtime services are basically opt-in already, and you
> are free not to invoke them (there are some exceptions here - there
> are some drivers that perform a getvariable() call at bind time iirc).
> The ACPI PRMT code is platform specific though, but I don't think you
> can run an RT kernel on those systems in the first place.
>
> In summary, I think we should make the firmware calling infrastructure
> play more nicely with RT, by switching to migrate_disable(), and
> reassess whether or not they must still be disabled at all times on
> such kernels.
>

Ard, interesting point, thanks. Let's see how RT people thinks about
your proposal.

Thanks
Dave

