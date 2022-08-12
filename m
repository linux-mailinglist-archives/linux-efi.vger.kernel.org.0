Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA639590A9A
	for <lists+linux-efi@lfdr.de>; Fri, 12 Aug 2022 05:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiHLDX1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 23:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbiHLDXN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 23:23:13 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A71A3475;
        Thu, 11 Aug 2022 20:23:12 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g5so31098602ybg.11;
        Thu, 11 Aug 2022 20:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=eZSj7ETI+iuiscrTI6+l4FTa1GjyXd9wkrgxBXiniks=;
        b=kmfXn4pWniW5YaVUVmQJRgxp4P0vztk0rDkk1n7MkgohYDbPwkWOylHKvStBaBM9He
         nuWiA3vqkXRP8uAMY0i8pk+iWIMhbQOk30vBCCfvJ5ST57loqYXGamTyzI39CVZ3KNQj
         btt0hmkINxeGbiCJNHUioE2xMhMDpi5dTA0nbtJHOpvZKWL3Q0+kVV31FLZAbb+d7izr
         Jb7YStTIoXHSacjYfBNshQ1s+ovjPWdzLCj9n2LLgwY8VS4G6viqqHDJ53rTGMHkFeDA
         ESQ7NrtFBXOTzWes/2l2LpdXWdxSCpdyBz1RTC1hOOnxVYCqEkImdZDhkAhO9NM8Qml0
         NjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=eZSj7ETI+iuiscrTI6+l4FTa1GjyXd9wkrgxBXiniks=;
        b=VNLmfHLmHs6PERWGvcm9kDawf7M9rVH6CBPYD9qzvIfJe4Z5ewu95fTNbcBsg21ZXh
         fyEB7WJHX1DazykgvpZGnbK90knn5j2tw4QdlO80mLSWQ60f8HWF3xTvegQOKdu+TgGp
         ziUfVyqgZG7PU1xhRnS5xh/GApEYbOVHlhcJvISE5myajIgfY5nQDIaJR98eFumOLBGP
         D3Ow675uvzSI2unn5F4BaLaBAuwjwXku+87Rk5pstAzuIVbz3gjtubivELXw1en/lF8O
         AZg9naQNsJ5guyUgi+vT0WmKp08evFnjSArlmOImFTy/PXVFpzZuUm3CYvCVdxAEV+9d
         kG4Q==
X-Gm-Message-State: ACgBeo3+gmuF9sw3lLyMHjQF62QMvvrUv5RyHzzovezEgTtHfPIpAuRD
        +XFeg0tNoC+zFMzNoo6VyyQotvn/HDRyXv4ulbs=
X-Google-Smtp-Source: AA6agR6+0FuRGI5TkiB4BlZTULVdxm6BPysYRXCjl1Lvw21aXjGFDJcxkUrwkO1xgExZUY+iSDkf0QG3Iz/sfn/N41A=
X-Received: by 2002:a25:d658:0:b0:67b:37ca:dc04 with SMTP id
 n85-20020a25d658000000b0067b37cadc04mr1944514ybg.431.1660274591570; Thu, 11
 Aug 2022 20:23:11 -0700 (PDT)
MIME-Version: 1.0
References: <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
 <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
 <f09fe749-e139-db6a-b2ad-45db76da04ae@apertussolutions.com>
 <CAELHeEe5H8BNf8K22XRm3hXf=_imHBnf-MHcFYvPCXX7GYkt4w@mail.gmail.com>
 <203110bb-b70b-b4f1-9453-46136659f84c@apertussolutions.com>
 <CAELHeEe2CiTXfMf3OYu3bzc_kH=rs4qzC-4XQL12AM=Nq8Csjw@mail.gmail.com>
 <20220810174638.GA7906@srcf.ucam.org> <CAELHeEdNgYCh_kQwWpEc4aXw-YL-KGrAeDCL-VaG3ChFs6LNVw@mail.gmail.com>
 <20220811182502.GA32433@srcf.ucam.org>
In-Reply-To: <20220811182502.GA32433@srcf.ucam.org>
From:   Brendan Trotter <btrotter@gmail.com>
Date:   Fri, 12 Aug 2022 12:52:58 +0930
Message-ID: <CAELHeEcfHSXewFCywsYeN_g8Q_BNG+4tP-QENO5QBw8Dj91yMA@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Alec Brown <alec.r.brown@oracle.com>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        "piotr.krol@3mdeb.com" <piotr.krol@3mdeb.com>,
        "krystian.hebel@3mdeb.com" <krystian.hebel@3mdeb.com>,
        "persaur@gmail.com" <persaur@gmail.com>,
        "Yoder, Stuart" <stuart.yoder@arm.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "michal.zygowski@3mdeb.com" <michal.zygowski@3mdeb.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "lukasz@hawrylko.pl" <lukasz@hawrylko.pl>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Fri, Aug 12, 2022 at 3:55 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Thu, Aug 11, 2022 at 07:25:58PM +0930, Brendan Trotter wrote:
> > On Thu, Aug 11, 2022 at 3:16 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > > The kernel has no way to know this - *any* code you've run before
> > > performing a measurement could tamper with the kernel such that it
> > > believes it's fine. This is just as true in DRTM as it is in SRTM. But
> > > you know what the expected measurements should be, so you're able to
> > > either seal secrets to those PCR values or rely on remote attestation.
> >
> > In this scenario the kernel has no idea what the measurement should
> > be, it only knows the measurement that a potentially malicious boot
> > loader felt like giving the kernel previously (e.g. when the kernel
> > was installed).
>
> Even if the kernel has an idea of what the measurement should be, it has
> no way to verify that what it believes to be true is true - any
> malicious code could simply have modified the kernel to believe that
> anything it asks the TPM returns the "correct" answer.

Right. To achieve the best possible security; you'd need Secure Boot
to ensure that the kernel itself wasn't modified, and then the kernel
establishes a dynamic root of trust itself.

Anything involving a boot loader (e.g. Secure Boot ensure's boot
loader wasn't modified, then boot loader ensure's kernel wasn't
modified, then ....) increases the attack surface for no benefit.

> > > Measurements are not opaque objects. If you're not able to reconstruct
> > > the expected measurement then you're doing it wrong.
> >
> > OK; so to detect if boot loader has always given kernel a bad/forged
> > measurement; the kernel repeats all of the steps involved in creating
> > the measurement itself exactly the same as the boot loader should have
> > (but might not have) so that kernel can compare a "known
> > good/trustworthy" measurement with the useless measurement that the
> > boot loader created for no sane reason whatsoever?
>
> No, some external agent does. Code running on the local machine can
> never determine whether the machine is trustworthy.

This part of the conversation evolved from "there's no way for kernel
to detect a MiTM boot loader (that provides a bad/forged
measurement)".

I'm not convinced an external agent can detect "bad/forged
measurement" either. E.g. if a MiTM boot loader always provided a
bad/forged measurement the external agent won't detect it (as the
measurement always matches the expected measurement), and then if the
MiTM boot loader is replaced by a good/honest boot loader the external
agent will decide that the good/honest boot loader is malicious
because its measurement doesn't match the expected bad/forged
measurement.

- Brendan
