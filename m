Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AA598623
	for <lists+linux-efi@lfdr.de>; Thu, 18 Aug 2022 16:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343544AbiHROjH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Aug 2022 10:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343538AbiHROjG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Aug 2022 10:39:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB741CB21;
        Thu, 18 Aug 2022 07:39:05 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98ec329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98ec:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B9A951EC0575;
        Thu, 18 Aug 2022 16:38:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660833539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g2YL7kh6clXEuknks5MxIzMwgBzNRg9SU8LpO1P7yIE=;
        b=UUPNhVpC1nJs8S6GR9rbE/LCJ5GGypAQXnws+gBg8kpr0anG6hrMsxpKD3JOAYD+5jPAce
        RblEzbEkn40zlzyyz95apBsukGMkp6Y6gfOfgThZtHGefttQmdKNjYIrlNQ6+Trz2usFaX
        qRUHlNVpUkfrxN57kjKdGmbzi2nF0m4=
Date:   Thu, 18 Aug 2022 16:38:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        toshi.kani@hpe.com, nd@arm.com
Subject: Re: [PATCH v2 1/7] efi/cper: export several helpers for ghes edac to
 use
Message-ID: <Yv5O/9WZ6sKwKWF8@zn.tnic>
References: <20220817143458.335938-1-justin.he@arm.com>
 <20220817143458.335938-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220817143458.335938-2-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 17, 2022 at 02:34:52PM +0000, Jia He wrote:
> Subject: Re: [PATCH v2 1/7] efi/cper: export several helpers for ghes edac to use

"ghes_edac"

> Before the ghes_edac codes are modularized, export several efi/cper helpers

"Before ghes_edac can be turned back into a proper module again, export
several helpers which are going to be used by it."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
