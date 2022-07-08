Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F8656B0E9
	for <lists+linux-efi@lfdr.de>; Fri,  8 Jul 2022 05:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236513AbiGHDge (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Jul 2022 23:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiGHDgd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Jul 2022 23:36:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FB735BD;
        Thu,  7 Jul 2022 20:36:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r76so2497989iod.10;
        Thu, 07 Jul 2022 20:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1nEpcbWWBpE3b8WlOr/etnrR3ATmUbpbxzoGFQMckxI=;
        b=mPxKB+MEqY67kiGFEE5EhZd4Bjphdd+29NRvv62yj1iiF/v2OcMFy52539cYwddbtx
         Vx3KEqqRZLPqtA0m1vMqWea9hUOfaNGwUMILEvWo7n48KmMgOjO9bRcig9M2oyI5lXvG
         agkhM/OfK2kRTPdSul+a3gcbs8+lWnDNQGaAlDhomiQOVdUjhTjkEQo63+NdMPZK39CZ
         50oUDIcdDd8toKyAXeuESn3ADdh5d/Z6/bhskSTRUxvVaBUX86sgPniwqZzeTrw9cbgV
         BEspLlFbzugBZvdOP8pMtEZZKytAsCnv/5t6zzKA5AXhrTkL493hkonoOcGIw3jRiY+h
         1vdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1nEpcbWWBpE3b8WlOr/etnrR3ATmUbpbxzoGFQMckxI=;
        b=67Xj/AKhecRgtb27WiytIOgLxXtlu4pW3AQMGlmtRvPSks3VuwwHFKeg02H35Qw6ee
         3BxNpfA0mankO/xAWOz4j6iTZT8xzxZ1yVthbiUI66nHy1GQJZmTSN1POUBV4eYRNcEa
         JddfqrHL4qvLmMYgyAuMpkQU/dRWQWAUs941Gzg4rajglDk0eis/uL1F3z9YF0bZjhgR
         j5aGYi1IVAXGMEJUcKEhvUcWUCKmyW3CwwfAuNCvohdEiuRNZr0Cv8jCjIfvX5COkvtM
         gD3TOC6H7peVcoAC1+OCqU4wZ8YcTz5+Dn4eEoErJHF5U2cEvrmn9ChWQ+VVE3E7znDp
         kdFg==
X-Gm-Message-State: AJIora8lYygXcEark5QVpfglZDHoJ/0eg7RRkgtPlqlEGH43fRzCVt4w
        yUUmjPmI0wVHWoaMyIjPj2BM66hmnIWqCBPyEp8=
X-Google-Smtp-Source: AGRyM1vdpip4CSiT7Uez+RwzkhWBuCEAcIGaSeqj6PrAhpBLP17jxBfwmU6cX1ShR23q8fZi4cZzVwNrhDy7SgQVRB0=
X-Received: by 2002:a05:6638:1493:b0:33e:c04e:56e4 with SMTP id
 j19-20020a056638149300b0033ec04e56e4mr971061jak.282.1657251391950; Thu, 07
 Jul 2022 20:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com>
 <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
 <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com> <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
In-Reply-To: <b1e7b545-8e66-5dc0-ff5a-9f69d1751a5f@apertussolutions.com>
From:   Brendan Trotter <btrotter@gmail.com>
Date:   Fri, 8 Jul 2022 13:06:19 +0930
Message-ID: <CAELHeEcEN=4YrPJROvzHoOiqqe5Bk0f8pDCZDnQ6aS=2LdwNow@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
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

On Thu, Jul 7, 2022 at 7:18 PM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
> On 7/5/22 20:03, Brendan Trotter wrote:
> Greetings!
>
> Not sure why I got dropped from distro, but no worries.
>
> > On Wed, Jul 6, 2022 at 4:52 AM Daniel P. Smith
> > <dpsmith@apertussolutions.com> wrote:
> >> On 6/10/22 12:40, Ard Biesheuvel wrote:> On Thu, 19 May 2022 at 22:59,
> >> To help provide clarity, consider the following flows for comparison,
> >>
> >> Normal/existing efi-stub:
> >>    EFI -> efi-stub -> head_64.S
> >>
> >> Proposed secure launch:
> >>    EFI -> efi-stub -> dl-handler -> [cpu] -> sl_stub ->head_64.S
> >
> > For more clarity; the entire point is to ensure that the kernel only
> > has to trust itself and the CPU/TPM hardware (and does not have to
> > trust a potentially malicious boot loader)..Any attempt to avoid a
> > one-off solution for Linux is an attempt to weaken security.
>
> Please elaborate so I might understand how this entrypoint allows for
> the kernel to only trust itself and the CPU/TPM.

Is this a serious request?

Kernel is started (via. firmware using the kernel's efi-stub, or via.
"kexec()", or..); and regardless of how the kernel was started the
kernel establishes its own dynamic root of trust.(e.g. AMD"s SKINIT or
Intel's TXT, followed by measuring the remainder of itself and
anything passed from firmware like APCI tables) without relying on a
call-back provided by "untrusted by kernel" third-parties that don't
exist in most cases. The dynamic root of trust that kernel creates
depends on the kernel, CPU, TPM, etc (and excludes untrusted and
unnecessary third parties)..

The only potential benefit that the callback solution provides is that
it, in theory, it could reduce duplication of work for other operating
systems (FreeBSD, Solaris, Haiku, Fuchsia, .. could use the same
callback instead of doing it themselves); but previous discussions
(talk of formalising the contract between the boot stub and the Linux
kernel) suggest that you aren't interested in any other OS.

This leaves me wondering what your true motivation is. Are you trying
to benefit GRUB/Trenchboot (at the expense of security, end-user
convenience, distro installer hassle, etc); or trying to manufacture
scope for future man-in-the middle attacks (by promoting a solution
that requires something between firmware and kernel)?

- Brendan
