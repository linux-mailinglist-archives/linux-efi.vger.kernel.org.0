Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23299553D8E
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 23:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355488AbiFUVXB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355464AbiFUVWi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 17:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7562F6;
        Tue, 21 Jun 2022 14:12:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA076155D;
        Tue, 21 Jun 2022 21:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDD8C341C4;
        Tue, 21 Jun 2022 21:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655845949;
        bh=nUYoRoex6w347HOwhaDxEO5t5c8d600lKv1dhQIfL5c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZbGRF/Y8Bn6KTBDQOCtPqsTiGZyLokKfBISfZJAG4yobQaKFvMV2Jck7Uyz14tUjw
         W8SqMmRA/nqwnxrLPI1ASP0cBWkpUiVPCCXGoacD3d8Gis5eI4FjMH0jwDHal4aVij
         gP7XFSac0HWyOg3tfsyz1dhmDLd6A4xiWC2Jwj6b1eOGWI+W5At3H/KYWL/+Mdqm6z
         joY8UCbXj+v+fA2B0n27l/cB0SFv4tZ6LkJsnWgTTc0sgqKPmbz9QQLOeR5TrWuxkz
         xrleY2ClSfYSEwyGccRtNLpEijg4US7s9tyzibRACrGJxdjxdpL8hzhL/GNhiNBWLo
         ERboSqUl81VjQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-101d2e81bceso11180349fac.0;
        Tue, 21 Jun 2022 14:12:28 -0700 (PDT)
X-Gm-Message-State: AJIora/yKFWUcduipDUo75V7CaCU9oPGBjW6m+y92yubfZ2KZQPSqWBC
        EgKGkIsdBx2AZghFOu6E1DAtREHgS1uiYlJD5Yg=
X-Google-Smtp-Source: AGRyM1tatOOl+GEd9ZOd7DehrkpsULz9y5U1aqhVWL3SL9NiTCcfADEG6C6z6SP1xp7bqTcqm4hJ4zAnDzQq+zbY6ow=
X-Received: by 2002:a05:6870:d587:b0:101:dfd4:4cfa with SMTP id
 u7-20020a056870d58700b00101dfd44cfamr41237oao.126.1655845948158; Tue, 21 Jun
 2022 14:12:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220621153623.3786960-1-ardb@kernel.org> <20220621153623.3786960-5-ardb@kernel.org>
 <202206211357.C66CD742E5@keescook>
In-Reply-To: <202206211357.C66CD742E5@keescook>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Jun 2022 23:12:17 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGPi+Cy-D8am8tr-rm8gbmUQ-G0bfibD3R3nx=rL7-XVw@mail.gmail.com>
Message-ID: <CAMj1kXGPi+Cy-D8am8tr-rm8gbmUQ-G0bfibD3R3nx=rL7-XVw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] efi: pstore: Omit efivars caching EFI varstore
 access layer
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 21 Jun 2022 at 23:00, Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Jun 21, 2022 at 05:36:18PM +0200, Ard Biesheuvel wrote:
> > Avoid the efivars layer and simply call the newly introduced EFI
> > varstore helpers instead. This simplifies the code substantially, and
> > also allows us to remove some hacks in the shared efivars layer that
> > were added for efi-pstore specifically.
> >
> > Since we don't store the name of the associated EFI variable into each
> > pstore record when enumerating them, we have to guess the variable name
> > it was constructed from at deletion time, since we no longer keep a
> > shadow copy of the variable store. To make this a bit more exact, store
> > the CRC-32 of the ASCII name into the pstore record's ECC region so we
> > can use it later to make an educated guess regarding the name of the EFI
> > variable.
>
> I wonder if pstore_record should have a "private" field for backends to
> use? That seems like it solve the need for overloading the ecc field,
> and allow for arbitrarily more information to be stored (i.e. store full
> efi var name instead of an easily-colliding crc32?)
>

We could easily add that - we'd just have to decide how to free the
memory it points to.
