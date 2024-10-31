Return-Path: <linux-efi+bounces-2078-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267669B7C64
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 15:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71271F216A2
	for <lists+linux-efi@lfdr.de>; Thu, 31 Oct 2024 14:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B717483;
	Thu, 31 Oct 2024 14:07:42 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EBB19DF99
	for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383662; cv=none; b=TuzPNFrLB+9FLLK/X8jWOeOGpZx6B7R6CBXubc+bTmL0T7eevSYqee0J4+x1TYSHIZkE7zhSRlbdmy6QAU+oaGq3rjvnoVzBHK3EdKnqd2tvXBvozbOYuXgiBrgy03vUNsjFlDIbuTsMjUb9TnlDrS46o64wIyaUygC4CmgReNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383662; c=relaxed/simple;
	bh=4B3We/xPt6QdmZZr+pmpoyzMEhku1zDpvKlE3USLaTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4PIKKVFyvrXuEPq7xqsDJ3wGnEcl4hyR9IfQlo7sjgvDwv4HYvzQoKTMcM27U+8w91OfvZPl4Wktm7RNsUKJAuefh12Zmb9IXFqweu8b4dqUlKfmXRkieMwcki8YbhZQEhIKvPicdFKoEXkN9EHWLumLyoT+H5D9yf7YRSYPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c9404c0d50so1007613a12.3
        for <linux-efi@vger.kernel.org>; Thu, 31 Oct 2024 07:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730383658; x=1730988458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FIDp1jfs5l9WI6pGEK2eGN/Sj/8Cl3bteLGURW/+os=;
        b=DISm9u0SZgWjU6YnWqj5T3/AZQCXur0YeECtE7lyBbuiI6xCK1TPOMp0X2ttVSohyz
         Cy38gcoaMajTLolLr10nePCl++oNIF5MMP7d9zBfUy6hnHhk0rBjxw1keCwxD5AxxZ1P
         /4x1KkWEHzzEZM76PXsarKF6PmG1ldfZwUX+VRr+eWJVh2hkNT7V6pUWifpS0hBl8RVA
         J2k1se8kZI9dQ2dnyEyN3Keoxd2/PabZxvINovWVM2LnAYDrt9PIUWvQFoXIW1dbg/TD
         i535cVlV9is7VHpdZ1xY+ik4Q5slHrhcQr25QzEoDS6hUFpk6mGeGExftdGDUJBWfRN5
         otaQ==
X-Gm-Message-State: AOJu0YxJYtm4IzKeVBqiUgu2ZflN+DYdhiwEHS1Z6g8Kkyu1ZO24vKCL
	UG10gRujJGhKh6tihSD28dFpi/Ra6O451FMcF3k/azqPTvgt1kfq
X-Google-Smtp-Source: AGHT+IGjbkFijP36kFzFAgtaDN/5VqlfB0RfU8I5xjDpgUHU/aYDkPAhigEfz7l0vPF/GQZdjoyeRQ==
X-Received: by 2002:a05:6402:5202:b0:5c9:5cff:3cc2 with SMTP id 4fb4d7f45d1cf-5cbbfa71a66mr13970308a12.29.1730383656665;
        Thu, 31 Oct 2024 07:07:36 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac76ffdcsm641324a12.28.2024.10.31.07.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 07:07:36 -0700 (PDT)
Date: Thu, 31 Oct 2024 07:07:34 -0700
From: Breno Leitao <leitao@debian.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	Gregory Price <gourry@gourry.net>,
	Usama Arif <usamaarif642@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] efi/memattr: Ignore table if the size is clearly bogus
Message-ID: <20241031-classic-eager-bullfrog-abe9ef@leitao>
References: <20241031104359.2613133-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031104359.2613133-2-ardb+git@google.com>

Hello Ard,

On Thu, Oct 31, 2024 at 11:44:00AM +0100, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> There are reports [0] of cases where a corrupt EFI Memory Attributes
> Table leads to out of memory issues at boot because the descriptor size
> and entry count in the table header are still used to reserve the entire
> table in memory, even though the resulting region is gigabytes in size.
> 
> Given that the EFI Memory Attributes Table is supposed to carry up to 3
> entries for each EfiRuntimeServicesCode region in the EFI memory map,
> and given that there is no reason for the descriptor size used in the
> table to exceed the one used in the EFI memory map, 3x the size of the
> entire EFI memory map is a reasonable upper bound for the size of this
> table. This means that sizes exceeding that are highly likely to be
> based on corrupted data, and the table should just be ignored instead.

First of all, *thank you* for the quick fix.

A few questions/thoughts that are still bugging me. If you know the
answer for any, I would appreciate hearing from you.

1) This patch protects the kernel from a broken firmware. It has nothing
to do with the kernel code. The kernel is being a victim here.

2) The bug reported in [0], clearly found that the problem was likely
introduced by 2e6871a632a99d9b9e2ce3a7847acabe99e5a26e[1] from a cold
boot. How it might be related to
2e6871a632a99d9b9e2ce3a7847acabe99e5a26e ?

3) Does having 2e6871a632a99d9b9e2ce3a7847acabe99e5a26e make the
firmware bug (EFI Memory Attribute Trable corruption) more visible by
any chance?

[1] https://bugzilla.suse.com/show_bug.cgi?id=1231465#c44
Thank you!
--breno

