Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEEE58FA4A
	for <lists+linux-efi@lfdr.de>; Thu, 11 Aug 2022 11:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiHKJ4N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 11 Aug 2022 05:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiHKJ4M (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 11 Aug 2022 05:56:12 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40937AC26;
        Thu, 11 Aug 2022 02:56:10 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-32194238c77so167748797b3.4;
        Thu, 11 Aug 2022 02:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=fwQUcv5ujbxHFhmwZIXEpylzN9K6eYzKvdzq8gW460k=;
        b=W2JCmFyw36TPiiYlXpt8XIMhf4jL8fBeavxF3RVQ4MO0ioDG9T36XnEIZcELI2I3Ez
         cAMWu4kgNZhbqn9DOfqbJROWucC2nnQZawxNo1iWeS2j9sZWn/QKU0WTACStWXgwDH02
         4EKq3aDoivjGqql07n3S1Th2IVf93gvjIMmQ2iGFW8sjEQrIw/G7yvyQylYiOjEDkiNz
         bEdqQeuexai4xwvy6VU/OUNzQ5EEqVd8+tWTZsROrAN2WlmBPgcEH8nwoTFqnQkwDiZa
         tXdy19QKEH2LsapBp3HjN7GM/2VRZrP2YfwbwqNw8aLcKjrdctgs3AnXc9AAnJgm7h8j
         KC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=fwQUcv5ujbxHFhmwZIXEpylzN9K6eYzKvdzq8gW460k=;
        b=yrxHWWutJSgHa66hLGJapsq0IVv/sbWqUob1jTIAVYArP79zG9fY0wkjDGbFvZvFs0
         HGWKKWrZsNWVYoojfEKpqTcNUygnKYVhEX1xfAOqEYDcdedeM8UMVwlxvDZpqwEqiCOB
         mitHTLkA3rEx+aQSx7KLHMxYDIAE1p4aUV8lP5+PSwKzWndcHd+pW24jKl3V7WbbYeIR
         8cG/3pRfxN8dj8BwPMkxHUPDIDqllG7DQwr7ei6wH652jblenN+2LkO/mIyo94BCSLJ8
         7H0amoGsBNbVgMXur82P3mZInqF+v5DQ+QOgGYEFrEMTpdbavVKgwVoQCbkq/JlPC7UE
         o1Yg==
X-Gm-Message-State: ACgBeo3TOHu2uWTVblsV/NE37p5P+RP7v6P3PDKZHlGLMIueqsxrJ3gZ
        53IR6S012wMVwifYRmYggQfvbd50JvT++WUlowU=
X-Google-Smtp-Source: AA6agR5/WapTssfcQ/DA4O1gE5u+PT2nJab9miAW7BuViSfiBauMIkLdsipQpxhXUp0NVgxB2l+QT0VGV90rNz5y0L0=
X-Received: by 2002:a0d:e252:0:b0:322:eca5:eaf3 with SMTP id
 l79-20020a0de252000000b00322eca5eaf3mr33153433ywe.219.1660211770246; Thu, 11
 Aug 2022 02:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
 <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
 <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
 <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
 <f09fe749-e139-db6a-b2ad-45db76da04ae@apertussolutions.com>
 <CAELHeEe5H8BNf8K22XRm3hXf=_imHBnf-MHcFYvPCXX7GYkt4w@mail.gmail.com>
 <203110bb-b70b-b4f1-9453-46136659f84c@apertussolutions.com>
 <CAELHeEe2CiTXfMf3OYu3bzc_kH=rs4qzC-4XQL12AM=Nq8Csjw@mail.gmail.com> <20220810174638.GA7906@srcf.ucam.org>
In-Reply-To: <20220810174638.GA7906@srcf.ucam.org>
From:   Brendan Trotter <btrotter@gmail.com>
Date:   Thu, 11 Aug 2022 19:25:58 +0930
Message-ID: <CAELHeEdNgYCh_kQwWpEc4aXw-YL-KGrAeDCL-VaG3ChFs6LNVw@mail.gmail.com>
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

On Thu, Aug 11, 2022 at 3:16 AM Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Wed, Aug 10, 2022 at 06:37:18PM +0930, Brendan Trotter wrote:
>
> > [1] doesn't provide any useful information. How does a kernel know
> > that the callback provided by boot loader actually measures what it's
> > supposed to measure, or even does anything at all?
>
> The kernel has no way to know this - *any* code you've run before
> performing a measurement could tamper with the kernel such that it
> believes it's fine. This is just as true in DRTM as it is in SRTM. But
> you know what the expected measurements should be, so you're able to
> either seal secrets to those PCR values or rely on remote attestation.

In this scenario the kernel has no idea what the measurement should
be, it only knows the measurement that a potentially malicious boot
loader felt like giving the kernel previously (e.g. when the kernel
was installed).

> > [1] doesn't provide any useful information. Senter and skinit don't
> > provide a method for kernel to detect that (e.g.) a MiTM boot loader
> > has always measured a forgery and has changed unmeasured code in a
> > different way every time you boot.
>
> Measurements are not opaque objects. If you're not able to reconstruct
> the expected measurement then you're doing it wrong.

OK; so to detect if boot loader has always given kernel a bad/forged
measurement; the kernel repeats all of the steps involved in creating
the measurement itself exactly the same as the boot loader should have
(but might not have) so that kernel can compare a "known
good/trustworthy" measurement with the useless measurement that the
boot loader created for no sane reason whatsoever?

- Brendan
