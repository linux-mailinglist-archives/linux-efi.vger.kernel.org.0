Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089D4567B0A
	for <lists+linux-efi@lfdr.de>; Wed,  6 Jul 2022 02:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiGFADi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 5 Jul 2022 20:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiGFADi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Jul 2022 20:03:38 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E8AE6F;
        Tue,  5 Jul 2022 17:03:35 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d3so12611156ioi.9;
        Tue, 05 Jul 2022 17:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F0Ccarqv3YPNINqL0C4ffqq3Htqc+EP6UGzPhZZVQoI=;
        b=pPMrOYPVZaO9h5iMRrcjWH4fvow/bdaWIh8gFkmc6I5gCr6Nf7belaC+1eZsdcMWcA
         oWLUW0MwolBZD3PDy+g+4WiLlahbkJIsgBQA81MdV1ffwIEVow/OZLZO/H/kuZao40x7
         Yv4AZv0q/hd7AJ+N6zcDPVKQH2K8xdDUrQ30Px7eLZUivPlvnmvo+zYnLtWw4UOew6DQ
         y49JUwpfBJIV2rjyCB+pXKL3KRvwXLeeMOvhng5QrXSmDHeTFZd4CpmulmsOl+khX04Q
         9W6/EhVNfd/SALcBHZfAPLMML5pZd+oVRAWvqTeKQtRAtBo6ofnweVXFBcs10HfQIRhD
         XleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F0Ccarqv3YPNINqL0C4ffqq3Htqc+EP6UGzPhZZVQoI=;
        b=izXHXQliGVuJdc5JMKG+tUnRr4rkx7yARQLwfS7UIl4KGEZRhx9wAe8dOTSorDd9g8
         QjwYRbPeWhs7gWRJDr/ekVvxCmLwUxF4dkYIkcEEJLQ90ui1XnB+S3hc8GJqdRYLCoEt
         YXGnU6kKUX79z/2JXuzfRtguBjQ6pj9v7Y4rBtMzypkjJ73SAsEYVGCppfYXeM96+OsR
         2DStxg9lq8T/0IxPLOLKsxxW3gxq5ECEBvRRFtW3qTTm3iBcuCnFF62L9vTh7D2U8hJH
         ORn1z5cAk+LmwRTQqaS2zYiaOK+5so+AQ2n8lM+frcdl0NFk8qLqcA127am/o2vK0xKH
         amEg==
X-Gm-Message-State: AJIora/es+5STMTxE09rFBaqraOir014XXy0gGomQiCYf/qIn0fr4w2N
        dlBW1N27rsWqp68ejOpAwA2N/5kClhhLxksKWww=
X-Google-Smtp-Source: AGRyM1t5keDX3DEeai2I+bmif5q4ftQ8GJWwJnAyAoQOoXCTHPXFPc4g75qrHDEZRz5VSx1zkrzfu6to8Me8nAaO/KI=
X-Received: by 2002:a05:6602:1802:b0:675:7d87:aacf with SMTP id
 t2-20020a056602180200b006757d87aacfmr20814174ioh.110.1657065814544; Tue, 05
 Jul 2022 17:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220329174057.GA17778@srcf.ucam.org> <f9622b47-c45f-8c91-cb85-e5db7fd541cf@apertussolutions.com>
 <CAMj1kXEUT8BK_akqjF1Wx0JkLniFyV_h9s1TfQnPqfxCHsKfWw@mail.gmail.com> <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
In-Reply-To: <7aab2990-9c57-2456-b08d-299ae96ac919@apertussolutions.com>
From:   Brendan Trotter <btrotter@gmail.com>
Date:   Wed, 6 Jul 2022 09:33:23 +0930
Message-ID: <CAELHeEfZ-feZnexp7Gx3VAJPerENcoO1Uccbe3xxUX95jvLUdA@mail.gmail.com>
Subject: Re: Linux DRTM on UEFI platforms
To:     The development of GNU GRUB <grub-devel@gnu.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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

On Wed, Jul 6, 2022 at 4:52 AM Daniel P. Smith
<dpsmith@apertussolutions.com> wrote:
> On 6/10/22 12:40, Ard Biesheuvel wrote:> On Thu, 19 May 2022 at 22:59,
> To help provide clarity, consider the following flows for comparison,
>
> Normal/existing efi-stub:
>   EFI -> efi-stub -> head_64.S
>
> Proposed secure launch:
>   EFI -> efi-stub -> dl-handler -> [cpu] -> sl_stub ->head_64.S

For more clarity; the entire point is to ensure that the kernel only
has to trust itself and the CPU/TPM hardware (and does not have to
trust a potentially malicious boot loader)..Any attempt to avoid a
one-off solution for Linux is an attempt to weaken security.

The only correct approach is "efi-stub -> head_64.S -> kernel's own
secure init"; where (on UEFI systems) neither GRUB nor Trenchboot has
a valid reason to exist and should never be installed.


Cheers,

Brendan
