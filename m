Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03A591272
	for <lists+linux-efi@lfdr.de>; Fri, 12 Aug 2022 16:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbiHLOqc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 Aug 2022 10:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237430AbiHLOqb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 Aug 2022 10:46:31 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948F29A94A;
        Fri, 12 Aug 2022 07:46:30 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 384A61EC064C;
        Fri, 12 Aug 2022 16:46:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660315585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZE4cCkZbxROOHz/5wltDy/Y6nvpYXY5aOAOz/2fLJ44=;
        b=Yi0gsn4GR+2/dcxTJLGyvLnJquvCP2enYPktmOSY+yKWcnm9WSOPESeLz7O7AHCumNC+C1
        ZldSCK0EOgHk4x0Xj2bGHWB3W5e7c3NnpsoAWSNihzNiTLwhFQ84SAYtxGNc9yDAGni/zx
        jvizcxgz9sWb2+CsjxtOhLEUfJjtF5Q=
Date:   Fri, 12 Aug 2022 16:46:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jia He <justin.he@arm.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, devel@acpica.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, linux-efi@vger.kernel.org,
        nd@arm.com, toshi.kani@hpe.com
Subject: Re: [PATCH 1/2] efi/cper: export several helpers for ghes edac to use
Message-ID: <YvZnwIMonymPDJSw@zn.tnic>
References: <20220811091713.10427-1-justin.he@arm.com>
 <20220811091713.10427-2-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220811091713.10427-2-justin.he@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 11, 2022 at 09:17:12AM +0000, Jia He wrote:
> Before modularizing the ghes_edac codes, we need to export several efi/cper

Who's we?

Please use passive voice in your commit message: no "we" or "I", etc,
and describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

Also, see section "Changelog" in
Documentation/process/maintainer-tip.rst

Bottom line is: personal pronouns are ambiguous in text, especially with
so many parties/companies/etc developing the kernel so let's avoid them
please.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
