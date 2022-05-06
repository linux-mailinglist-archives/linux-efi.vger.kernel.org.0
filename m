Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2134051DF16
	for <lists+linux-efi@lfdr.de>; Fri,  6 May 2022 20:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347958AbiEFS3v (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 6 May 2022 14:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiEFS3u (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 6 May 2022 14:29:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3854C46B0B;
        Fri,  6 May 2022 11:26:06 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-002-247-254-212.2.247.pool.telefonica.de [2.247.254.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D11B1EC01B5;
        Fri,  6 May 2022 20:26:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1651861560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lnptI7P6U9gMOK+00VQGCG5CfCdJFwofyyQn9dmbmtk=;
        b=TyRd62KQTg/LyhQp6/QPwZvfdE/pdL3FhjwrNvGEedYo1AGp3KQu5rY0k40GFuC3CTWFvr
        7A55tb1Ujj1dWjDgwIlih8kl/5pGjZ189zgXvaklRFxdaZAOyh/uHaTQMTFr0w51geHbyx
        HF9t6+00QBZR6W3EMDoT9Y8Ktvr20e0=
Date:   Fri, 06 May 2022 18:25:56 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Martin Fernandez <martin.fernandez@eclypsium.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        platform-driver-x86@vger.kernel.org, daniel.gutson@eclypsium.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Darren Hart <dvhart@infradead.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, alex.bazhaniuk@eclypsium.com,
        hughsient@gmail.com, Andy Shevchenko <andy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        "Huang, Kai" <kai.huang@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_0/8=5D_x86=3A_Show_in_sysfs_i?= =?US-ASCII?Q?f_a_memory_node_is_able_to_do_encryption?=
User-Agent: K-9 Mail for Android
In-Reply-To: <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
References: <20220429201717.1946178-1-martin.fernandez@eclypsium.com> <YnKr+aMf4PspDpHZ@zn.tnic> <CAKgze5YDD02AsrF0yESv2sptZ4qxyTMgCDmnOKcbQWjKQsJRsw@mail.gmail.com> <YnUYLDjIThbIz/Uf@zn.tnic> <6d90c832-af4a-7ed6-4f72-dae08bb69c37@intel.com> <CAPcyv4i73m6iPPfJE9CBdxf-OWGXahvGqvh6G-pqVO=3LB6ktQ@mail.gmail.com> <47140A56-D3F8-4292-B355-5F92E3BA9F67@alien8.de> <6abea873-52a2-f506-b21b-4b567bee1874@intel.com>
Message-ID: <FDABC5C8-B80A-4977-9F97-5A8FC47F69D6@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On May 6, 2022 6:14:00 PM UTC, Dave Hansen <dave=2Ehansen@intel=2Ecom> wrot=
e:
>But, this interface will *work* both for the uniform and non-uniform
>systems alike=2E

And what would that additional information that some "node" - whatever "no=
de" means nowadays - is not encrypted give you?=20

Note that the fwupd use case is to be able to say that memory encryption i=
s active - nothing more=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
