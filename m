Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E226B5F9BC6
	for <lists+linux-efi@lfdr.de>; Mon, 10 Oct 2022 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiJJJWH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 10 Oct 2022 05:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiJJJWE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 10 Oct 2022 05:22:04 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931BB5D132;
        Mon, 10 Oct 2022 02:22:00 -0700 (PDT)
Received: from nazgul.tnic (unknown [46.183.103.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F41511EC06BD;
        Mon, 10 Oct 2022 11:21:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1665393714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ETrGB0sl7q4uIl8VhsdFLNWdcz2tzkFWu01gPVIh6LI=;
        b=n7kn6vQFklwYs/XvgVSolrdar/DypORzVjx7wknm1TlPgZt1k1euYyDdKQia/OugEatY1c
        XvuaK9eYT0BZDeo5c63Ba71bGgbZEtRu4pZ/Apb3wHglJZIKJyCT+kN9A/l2Voh4FXI9tj
        zMLFUmjBaKUiuIWxbTInEsHz5WZS9C8=
Date:   Mon, 10 Oct 2022 11:21:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] efi: x86: Make the deprecated EFI handover protocol
 optional
Message-ID: <Y0PkJWit8R2AtUmc@nazgul.tnic>
References: <20221007172918.3131811-1-ardb@kernel.org>
 <Y0GOKnD89SOjGzCf@nazgul.tnic>
 <CAMj1kXHK_9iDT8CSHnZ15yB+Z=+haZXjbQ99m20jQUr0NScK4Q@mail.gmail.com>
 <Y0GcZQZTaCgoNFGa@nazgul.tnic>
 <CAMj1kXE6L+aNJCCcq=A3q=oG-e83JA=iA1ujSaat0BRjgyH0XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXE6L+aNJCCcq=A3q=oG-e83JA=iA1ujSaat0BRjgyH0XA@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Oct 10, 2022 at 10:59:24AM +0200, Ard Biesheuvel wrote:
> Yes, this is going to take time. But we simply cannot get rid of it
> today, so the choice we have is between doing nothing at all, or
> taking the next step in phasing out this stuff.

Yes, next step ofc. This is simply the next thing we're deprecating.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
