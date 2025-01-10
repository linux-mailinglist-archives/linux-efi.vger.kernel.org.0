Return-Path: <linux-efi+bounces-2560-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0ADA085B1
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 03:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3C816A321
	for <lists+linux-efi@lfdr.de>; Fri, 10 Jan 2025 02:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368291E1C3A;
	Fri, 10 Jan 2025 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXDFCqcG"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766882A1BA
	for <linux-efi@vger.kernel.org>; Fri, 10 Jan 2025 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736477431; cv=none; b=FOHADC99pMJOCzOWfg1MXvy6SGbfRtHJNcTOj/bxBLJCDpk/3hA/C49fWDHjFcvz8V0y82E/G5XXUdW7bSC/ASv/MVQb7UfXHYVmCHuHIHOXcIUtD3Kf09jxpSep2O+4iyUtQ5/IykWLCXGU51TXoT08G0wNEvhXwFKc46fJaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736477431; c=relaxed/simple;
	bh=n6aB+swZq8A9ckA8obcO/lCaWFsvTcKE5xi4MIZNLu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMioCchIsnZZpR+dRKiXBSKQUEGb0JM7jfJpEPdlGRPUEVlg9kBk4woqScyLFtUJFVn7FrwK1jUjL3qsTsDCdDy7r5ZVr4mF+1ditxO63gtiideUPljbG1P3qAVVxv2TtepJYy3FXyJMpcgUq5RyQYZv56Z1zsd2oOoMtXgzfEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXDFCqcG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736477428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l28W7IOIAFJp9UnHqZfLXzZT+Zn5UtLpsfOiE7ovBeo=;
	b=UXDFCqcGLesHDW9z5kDZXcLf+evzqvcQni9N2FLrnVkqzG6ixLST57LEjxWNgL43mP0afM
	xOut4sakOWZ9aWj//XGXqdT8Z66PzPNtYiEz1EjRZpcLlU78bed1zcyan+/SdrpUBhgxi4
	UOWHQbi2+RkS2uG/SZMNd6SNfzN1ITg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-iXqoTEqZOfCWZL4TyRQ28Q-1; Thu, 09 Jan 2025 21:50:26 -0500
X-MC-Unique: iXqoTEqZOfCWZL4TyRQ28Q-1
X-Mimecast-MFC-AGG-ID: iXqoTEqZOfCWZL4TyRQ28Q
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a81684bac0so26467165ab.0
        for <linux-efi@vger.kernel.org>; Thu, 09 Jan 2025 18:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736477426; x=1737082226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l28W7IOIAFJp9UnHqZfLXzZT+Zn5UtLpsfOiE7ovBeo=;
        b=n8hO4kIyYK+Csu0KPr15YqyW8orUQ/tDDjRSF5oD/vbJQNqdI2A1dV8MjfAnEKOR8f
         8yTsWRx+7nbB2zU9ZoigRFpkZVX2Bj9ELeZ+HqJQPfqK0rUwFAW/IB/Nh/VGIa8YhuQU
         mCWotNwalCsl8JuavXQhIZx1SkdPRPgubTIVtNmxmnCXtNd3z+UzhCjVBR03aZ95K8k3
         GFK3toGDqT1HIvqyvDszCMRQ2fkeo++8gPgWP+8Z5fnr6nbc5jGrbtDK08vtJ1GfwkvS
         0QAwuz30ht99IE1nqFHy3Bet7GzXfPiWLAbwEgibC8uJpyZhgbBMDNm9ptrCkkpo0nL3
         NYTg==
X-Gm-Message-State: AOJu0YziNlxzXGhWJWJ7pIZufRqs95Z2SFVenfvr8Y7dcHPAmOdujZc0
	96fPJqO8Oa0jtaslRY34wAevKMS4AG8XTSFiKzIjhA8LA7GWvHgvnwuBdJ2Yx36vWAxqP4WBmXP
	ZerFo4iSZBNduD8YxRNAWTC1MOWsKDBbJNJZvoeootowPmXNQQV+uv2MNEQgSdtz5G0NanwGeN5
	jY62GMFNvwCCPZIjCaY4RLvt78F8yiIME0
X-Gm-Gg: ASbGncu26M+iy/F16Vw42j+Ca4gJJiyTNy/Rr4e4tnc8Pv2VP6sXJ6r3HZgsxx/WZhZ
	8NFKfsFS7yMXEF9WxG3e/+4xuYaAdT7e1uIJUxaU=
X-Received: by 2002:a05:6e02:1b03:b0:3a7:e539:c27b with SMTP id e9e14a558f8ab-3ce3a8bebd1mr56015695ab.17.1736477426102;
        Thu, 09 Jan 2025 18:50:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDGtliUz8u4ArhQvsNK3hU4dY2KdsRiD/CY4zDcby6FNqeeWso+rG5xRZbGE13XAQ77Nf1qFOrtPh284YbRLQ=
X-Received: by 2002:a05:6e02:1b03:b0:3a7:e539:c27b with SMTP id
 e9e14a558f8ab-3ce3a8bebd1mr56015555ab.17.1736477425788; Thu, 09 Jan 2025
 18:50:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108215957.3437660-1-usamaarif642@gmail.com> <20250108215957.3437660-3-usamaarif642@gmail.com>
In-Reply-To: <20250108215957.3437660-3-usamaarif642@gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 10 Jan 2025 10:50:30 +0800
X-Gm-Features: AbW1kvYxA86BWuq5GqR14CbuyK2tb5JSgfWl1vXKLE_oVV-bgv-0DWHCSCe-nz4
Message-ID: <CALu+AoTgjdq+kUbv-5CGQr=UTLd2+zDLbHt=kXaoMYYptBYnAA@mail.gmail.com>
Subject: Re: [RFC 2/2] efi/memattr: add efi_mem_attr_table as a reserved
 region in 820_table_firmware
To: Usama Arif <usamaarif642@gmail.com>
Cc: linux-efi@vger.kernel.org, devel@edk2.groups.io, kexec@lists.infradead.org, 
	ardb@kernel.org, hannes@cmpxchg.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, leitao@debian.org, gourry@gourry.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Hi Usama,

On Thu, 9 Jan 2025 at 06:00, Usama Arif <usamaarif642@gmail.com> wrote:
>
> When this area is not reserved, it comes up as usable in
> /sys/firmware/memmap. This means that kexec, which uses that memmap
> to find usable memory regions, can select the region where
> efi_mem_attr_table is and overwrite it and relocate_kernel.

Is the attr table BOOT SERVICE DATA?  If so, does efi_mem_reserve()
work for you?
Just refer to esrt.c.

Thanks
Dave


