Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6267ACE91
	for <lists+linux-efi@lfdr.de>; Mon, 25 Sep 2023 05:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjIYDCn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 24 Sep 2023 23:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjIYDCm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 24 Sep 2023 23:02:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2DBAA4
        for <linux-efi@vger.kernel.org>; Sun, 24 Sep 2023 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695610909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOHyP9dpBU8YM0EPdsfU1fLNnKIO6S+xWw3yNzjJANc=;
        b=R3KG705FKWRWfhwMdHZpqwoTd1zZZ0UDFL9GEKFyeZWp8y3Us2lnHfod8ESWF0na9UAsC+
        lF5Cim+QOBvzOeNJQsphFOuMVD0ozaHI69v5OoDWVK7pxAj+xpYwxqOQsZauQXuo5PVKL3
        uukHzki00QSIlQb9EHbicUpYHNci7Fs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-BAQ9e67eMoSZa2mHIGgfxg-1; Sun, 24 Sep 2023 23:01:47 -0400
X-MC-Unique: BAQ9e67eMoSZa2mHIGgfxg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-65b08994e15so14203766d6.0
        for <linux-efi@vger.kernel.org>; Sun, 24 Sep 2023 20:01:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695610907; x=1696215707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EOHyP9dpBU8YM0EPdsfU1fLNnKIO6S+xWw3yNzjJANc=;
        b=C7+I/txLpjTrJnNbSn+57OQPshTtLuP06DNEQPq3pe584X2N4dIuzR3LUFOSdqIKiG
         uJ9nJbJrD3vtK6zGKaNBrFwwJ4nEbXemUvCdwqbMNfLih73Tkud47HoOi/j9IHHydtvO
         rhLIAn+TwjNgPSebfN5EiGafSjq5TyQCOaZSufnYcOaIVDUNonHKmV69JCQuvGtcyAZx
         IwuDKr2unQG9yZ2x+rNVfKlKttMSMhdVr27aQ0bgVnTjeRs9EaCsyt8U2KX34bnHLUcP
         P8ITGs6ct5CnPyRxSO+NycXFBuh6Gsp+fls6rr1gCrVKij9Rk8FNmqDeqGbEOvssJG+H
         KB1g==
X-Gm-Message-State: AOJu0YzGJcAniduYtlIeoMlSpDJEzRAGl7oXa9ilm59Y80eeqL115AWO
        lGQEbDljJ9tLwiLlrLZ8wYoDhR877WPDpZ8gZIJVI59/Kk4TuWCfmkz8Bs6VO4CmppUQEVY/btY
        bIjQ6fnXNo6gC7dx6JkZZziVLAshXGf/1vQUD
X-Received: by 2002:a0c:b459:0:b0:656:35ec:b6cc with SMTP id e25-20020a0cb459000000b0065635ecb6ccmr8282625qvf.23.1695610907032;
        Sun, 24 Sep 2023 20:01:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRlbRHh9+wHvQRrykeaUSkbeKsmrCoBKl8cLZE+5UxoAeDb96dOZs0OFoN5RbYbzjz0eY7ZSAk7JQuLEhiaiQ=
X-Received: by 2002:a0c:b459:0:b0:656:35ec:b6cc with SMTP id
 e25-20020a0cb459000000b0065635ecb6ccmr8282603qvf.23.1695610906749; Sun, 24
 Sep 2023 20:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133703.39042-1-kernelfans@gmail.com> <ZQ0j6Es88aR8cjRv@desktop>
In-Reply-To: <ZQ0j6Es88aR8cjRv@desktop>
From:   Pingfan Liu <piliu@redhat.com>
Date:   Mon, 25 Sep 2023 11:01:35 +0800
Message-ID: <CAF+s44R0ty0-aV+Amw2pL58YGa4JHt_y0WpiDMzehULPiC_aJw@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Philipp Rudo <prudo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, keyrings@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, lennart@poettering.net,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Sep 22, 2023 at 1:19=E2=80=AFPM Jan Hendrik Farr <kernel@jfarr.cc> =
wrote:
>
> Hi Pingfan!
>
> On 21 21:37:01, Pingfan Liu wrote:
> > From: Pingfan Liu <piliu@redhat.com>
> >
>
> > For security boot, the vmlinuz.efi will be signed so UEFI boot loader
> > can check against it. But at present, there is no signature for kexec
> > file load, this series makes a signature on the zboot's payload -- Imag=
e
> > before it is compressed. As a result, the kexec-tools parses and
> > decompresses the Image.gz to get the Image, which has signature and can
> > be checked against during kexec file load
>
> I missed some of the earlier discussion about this zboot kexec support.
> So just let me know if I'm missing something here. You were exploring
> these two options in getting this supported:
>
> 1. Making kexec_file_load do all the work.
>
> This option makes the signature verification easy. kexec_file_load
> checks the signature on the pe file and then extracts it and does the
> kexec.
>
> This is similar to how I'm approaching UKI support in [1].
>

Yes, that is my original try.

> 2. Extract in userspace and pass decompressed kernel to kexec_file_load
>
> This option requires the decompressed kernel to have a valid signature on
> it. That's why this patch adds the ability to add that signature to the
> kernel contained inside the zboot image.
>

You got it.

> This option would not make sense for UKI support as it would not
> validate the signature with respect to the initrd and cmdline that it
> contains. Am I correct in thinking that there is no similar issue with
> zboot images? They don't contain any more information besides the kernel
> that is intended to be securely signed, right? Do you have a reference

If using my second method, it means to unpack the UKI image in user
space, and pass the kernel image, initrd and cmdline through
kexec_file_load interface. If the UKI can have signature on the initrd
and cmdline, we extend the capability of that interface to check those
verification.

> for the zboot image layout somewhere?
>

Sorry that maybe there is no document. I understand them through the code.
The zboot image, aka, vmlinuz.efi looks like:
PE header, which is formed manually in arch/arm64/kernel/head.S
EFI decompressor, which consists of
drivers/firmware/efi/libstub/zboot.c and libstub
Image.gz, which is formed by compressing Image as instructed in Makefile.zb=
oot


> > I hesitate to post this series,
>
> I appreciate you sending it, it's helping the discussion along.
>
> > [...] since Ard has recommended using an
> > emulated UEFI boot service to resolve the UKI kexec load problem [1].
> > since on aarch64, vmlinuz.efi has faced the similar issue at present.
> > But anyway, I have a crude outline of it and am sending it out for
> > discussion.
>
> The more I'm thinking about it, the more I like Ard's idea. There's now
> already two different formats trying to be added to kexec that are
> pretty different from each other, yet they both have the UEFI interface
> in common. I think if the kernel supported kexec'ing EFI applications
> that would be a more flexible and forward-looking approach. It's a

Yes, I agree. That method is attractive, originally I had a try when
Ard suggested it but there was no clear boundary on which boot service
should be implemented for zboot, so I did not move on along that
direction.

Now, UKI poses another challenge to kexec_file_load, and seems to
require more than zboot. And it appears that Ard's approach is a
silver bullet for that issue.

> standard that both zboot and UKI as well as all future formats for UEFI
> platforms will support anyways. So while it's more work right now to
> implement, I think it'll likely pay off.
>
> It is significantly more work than the other options though. So I think
> before work is started on it, it would be nice to get some type of
> consensus on these things (not an exhaustive list, please feel free to
> add to it):
>

I try to answer part of the questions.

> 1. Is it the right approach? It adds a significant amount of userspace
> API.

My crude assumption: this new stub will replace the purgatory, and I
am not sure whether kexec-tools source tree will accommodate it. It
can be signed and checked during the kexec_file_load.

> 2. What subset of the UEFI spec needs/should to be supported?
> 3. Can we let runtime services still be handled by the firmware after
> exiting boot services?

I think the runtime services survive through the kexec process. It is
derived from the real firmware, not related with this stub

> 4. How can we debug the stubs that are being invoked?
> 5. Can we let the EFI binary know that this is a kexec and not a normal
> bootup. Potentially systemd-stub would want to change how/if it does TPM
> PCR measurements.
> ...
>

Besides these questions, I wonder whether a highly configured EDK2 can
be used as the stub (ArmVirtQemuKernel.dsc can be the start point).
But there should be efforts to exclude the drivers which have the MMIO
access. I saw Ard is active in EDK2, maybe that is the reason why he
did not pick up EDK2 to serve the stub.


Thanks,

Pingfan

