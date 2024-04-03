Return-Path: <linux-efi+bounces-918-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A43896FFA
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 15:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88AF21F285F8
	for <lists+linux-efi@lfdr.de>; Wed,  3 Apr 2024 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA94147C95;
	Wed,  3 Apr 2024 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPPvgC9r"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AC614831E
	for <linux-efi@vger.kernel.org>; Wed,  3 Apr 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150155; cv=none; b=nv/pooWkApEmzRkG/d35hHPOmbtzGDMda9RVn0FSTHo++1WCFYjNJsgD60tGrs/6vol0BdgpXHiKGE+SbfDVHH8FH/Ql9ifDMRDVZT+EuJn771bpVgA2p3WPvmn7yRjHUK0H1KTIaLijqgx2Igvjgbnt/zWBdmykOfiB7z5JVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150155; c=relaxed/simple;
	bh=BvY7n2GM32YM2EPuTXqQK41U/DifdKggfolJTvMcnKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R4c7FzwqtCoWiG+3/cS4AaU5bDD6WGw+VHqJfhnbWzmNELywKSBeY3YBCWT7XRFHa5sdBhqr0oKfjeEQfH2tDhaO5aDfa+UeoFYyzV2bTC32zrXJ72xA889FEu9sNgQ9jGqDFMzo/cQQUFyfDsiiz4rmC1+acPCctvAOFRiB3r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPPvgC9r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712150153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8EVms2YLsDUuCYIw5cPdoEBYXqHd2OjbZnSw2iHHs/8=;
	b=KPPvgC9rx4X6Hgcy1e1slkm6rsCzwL3sI6Ceplf/LX9Pqy5GJ6HKd2w14zRiDJ+rOky6Pt
	NxaEW2VFy+iT8UHFltdiutTblJ+B7enHfQVTXxIa/IQcLYnSjLxK76U+TepTrMvvhiyPE1
	z9wAsbFdMZcsU9vGuyDJyhbgLGlX19U=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-LeCBoHk7NyC9Beax0jwbVQ-1; Wed, 03 Apr 2024 09:15:51 -0400
X-MC-Unique: LeCBoHk7NyC9Beax0jwbVQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d48d13b3c9so49396501fa.1
        for <linux-efi@vger.kernel.org>; Wed, 03 Apr 2024 06:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150150; x=1712754950;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EVms2YLsDUuCYIw5cPdoEBYXqHd2OjbZnSw2iHHs/8=;
        b=IRr0yKP8YKq/aSD6u0li9pdh1/yso4TEPh0GWjfcY6vJ7i9zoST04L6Ah9bNn5WsU0
         NvJyBFitFEmGfsO3RErlR/XRcofcwioopmgqVpqYGxNC8Jbb/UFDAC/nK3ocWapus6Ii
         sKUWHB83rGuco5P+pqQ/ut4ZCCUiquRdjWGhy3jGJ3LnsJQsVHQfKJmkZ/5++FI3yjM1
         xw22OBjgSRuGaffzIACL7VINPuf19pnPMKMq2Xb/sXa6B69lZgYvsspoiwvgPnyr+pkS
         MBuV261tyvDmG7U5Vf+GhV4CVCsQinCsOfIfMVwOhbOCVBzsImJ2lkb+xQxvao1B4t9/
         tJYA==
X-Forwarded-Encrypted: i=1; AJvYcCXbeP24UHDagYw0GnjnaV05t6qwiS2RCYh1XhenDHXzzCInTjST6B4hKcUfCbjbrdXa+0t83GGqCdzqCRcuNpJSN8izc+BFcb8T
X-Gm-Message-State: AOJu0YwnRK5UxPA9Gv9oXvFNFCKYmJm7YIpomdboqjep0V2oMIrbS7BJ
	zH63mH9LTok2c9DA5L45/muTAoIhds3Y2zLnUslnXIlwEmdpylis8DStH3CDkFREV05tCpXY+4G
	YN2r53aapPyoZlcLFlY8BcC808DrsvFPC4CsVPu8pVM6a0ligoAZU+XXLzw==
X-Received: by 2002:a2e:a795:0:b0:2d8:2cd3:aa51 with SMTP id c21-20020a2ea795000000b002d82cd3aa51mr2201598ljf.53.1712150149811;
        Wed, 03 Apr 2024 06:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFflOgcZSGdO/Ti5VsWhuXmDQ+H6zSOAqVtN4QkVE3bUJKOVJce9cVFlwkyt8RksgYYDBkyKg==
X-Received: by 2002:a2e:a795:0:b0:2d8:2cd3:aa51 with SMTP id c21-20020a2ea795000000b002d82cd3aa51mr2201570ljf.53.1712150149275;
        Wed, 03 Apr 2024 06:15:49 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c500b00b0041624540918sm1692064wmr.9.2024.04.03.06.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:15:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Masahisa Kojima
 <masahisa.kojima@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob
 Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH 10/34] efi: sysfb: don't build when EFI is disabled
In-Reply-To: <CAMj1kXG2kcAmmB5aQRv5VBJ8Ov2fcg5waGpD1r=aOR9rV=dSWg@mail.gmail.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-11-arnd@kernel.org>
 <CAMj1kXG2kcAmmB5aQRv5VBJ8Ov2fcg5waGpD1r=aOR9rV=dSWg@mail.gmail.com>
Date: Wed, 03 Apr 2024 15:15:48 +0200
Message-ID: <87jzle1ta3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ard Biesheuvel <ardb@kernel.org> writes:

> On Wed, 3 Apr 2024 at 11:09, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> With 'make W=1', there is a warning when EFI is turned off but sysfb_efi
>> still gets built:
>>
>> drivers/firmware/efi/sysfb_efi.c:188:35: error: unused variable 'efifb_dmi_system_table' [-Werror,-Wunused-const-variable]
>> static const struct dmi_system_id efifb_dmi_system_table[] __initconst = {
>>                                   ^
>> drivers/firmware/efi/sysfb_efi.c:238:35: error: unused variable 'efifb_dmi_swap_width_height' [-Werror,-Wunused-const-variable]
>> static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>>                                   ^
>> drivers/firmware/efi/sysfb_efi.c:297:28: error: unused function 'find_pci_overlap_node' [-Werror,-Wunused-function]
>> static struct device_node *find_pci_overlap_node(void)
>>
>> There was an earlier patch to address the duplicate function definitions, but
>> that missed how we should not be building this file in the first place.
>>
>> Fixes: 15d27b15de96 ("efi: sysfb_efi: fix build when EFI is not set")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
>

Looks good to me too.

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

> or I can take it via the EFI tree if you prefer.
>

I think that could be merged through your EFI tree. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


