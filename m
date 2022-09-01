Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7904D5A89FB
	for <lists+linux-efi@lfdr.de>; Thu,  1 Sep 2022 02:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbiIAAtL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 31 Aug 2022 20:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiIAAtJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 31 Aug 2022 20:49:09 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700DBE97E6
        for <linux-efi@vger.kernel.org>; Wed, 31 Aug 2022 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661993347;
        bh=gO5Y+Qdzo0260Jg48AG5SUnvAOPEHgswqk+/F8FHWyc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DBQqUSLRPz88mAaGWFZ+QqNmjjFRrPy6DSitF81ZKLiTdlJWj48zPOyPcH+itWO1V
         EK95ioa89MLhBYAiuXcYbbpjo4GQlWESswb7BHte86bvrOh3H3InoKgiLLK+TUm09S
         ta5DAqvngoXsT0ghpzV6gX0wj/RaGya48XglD2bA=
Received: from [IPv6:240e:358:118a:f800:dc73:854d:832e:4] (unknown [IPv6:240e:358:118a:f800:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 134CC65C5C;
        Wed, 31 Aug 2022 20:48:59 -0400 (EDT)
Message-ID: <1001ecbb485285e3d09b2e1a788dfd3c22396077.camel@xry111.site>
Subject: Re: [PATCH v4 6/9] arm64: efi: enable generic EFI compressed boot
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atishp@atishpatra.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Lennart Poettering <lennart@poettering.net>
Date:   Thu, 01 Sep 2022 08:48:55 +0800
In-Reply-To: <d58f870f-c41c-9d4b-4dc8-83ef4efe5ce9@arm.com>
References: <20220827083850.2702465-1-ardb@kernel.org>
         <20220827083850.2702465-7-ardb@kernel.org>
         <d58f870f-c41c-9d4b-4dc8-83ef4efe5ce9@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.2 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2022-08-31 at 17:05 -0500, Jeremy Linton wrote:
> So, now the fun bit. At the moment my shim->grub->efi-stubbed kernel=20
> path (which is the default fedora/rhel sequence) appears to be broken if=
=20
> I swap the compressed image (not the .gz version) in for a normal=20
> decompressed kernel. That appears to be a grub bug in fedora at the=20
> moment, but I've not fully tracked it down.

GRUB will need to be patched for generic EFI zboot:
https://lists.gnu.org/archive/html/grub-devel/2022-08/msg00113.html
--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
