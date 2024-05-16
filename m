Return-Path: <linux-efi+bounces-1048-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD8A8C7CB2
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 20:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CD38B21027
	for <lists+linux-efi@lfdr.de>; Thu, 16 May 2024 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD047156F39;
	Thu, 16 May 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TaacrotE"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E42156F28
	for <linux-efi@vger.kernel.org>; Thu, 16 May 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715885705; cv=none; b=Wl6UO6oUN44tf2GM6kgJAGwx0fw9tOU3H0j6Ym+lvZxenJ1vD44pGRPNVbQyxJ09k07T4Xqwi9/6SpFt/U/+wf+Af5ktAZZON1KtHh93COTFCIYKGnyRtqDN7rICF4hCXypQjWxFOeodzdZfv++TECYAeYADSTcBJUtjDtQ4e6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715885705; c=relaxed/simple;
	bh=cn+rbKU4Nj4tQx9dF4d/u1kehcthPaTDE6iwoDSE9v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLFMm73TYlAZR5w2hOIEA+u2OOFdA2WMKrwkpnxViiCPTxHzwcHqimlOTJ4m/4ldNPCtKnNg8rOMcVpvKgksZJw5/IDk6a3Hp7N9WViwHfLIbevvthvWiqiGaHbIpggJ9paVcvHzNL5qMWPaDg6x7A7S5f3YYLOvZejtTNO5RfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TaacrotE; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f449ea8e37so495750b3a.3
        for <linux-efi@vger.kernel.org>; Thu, 16 May 2024 11:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715885703; x=1716490503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fLvVPaGthcsDeYUgK994Dv4j8E5kvcQxmFSF+94OK3U=;
        b=TaacrotE3yRI2+W1PfJbx76HN2QVcQn1ZSQgnd+TV0/v6LMASLZ02GHbeFlOsMGW5V
         /gYhFcWsXOrqPQSBoN7tt59QmZ0pFfI4jJ9DOBuDdBJW12227KcqAv9fg9jmtwJpDick
         ftLD+Eyhbb+P6eROO593YJlnLhDJfqoXCFwzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715885703; x=1716490503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLvVPaGthcsDeYUgK994Dv4j8E5kvcQxmFSF+94OK3U=;
        b=d9jCt+VoqiueSmVkJzvCOBcmHLbuLygw4a3TlGSn/N633jthloMf1KdyLhj9qXIleG
         qS3eHRFobwNdWbuV9IESUbz1Lvhgac3fG4Dwmx+rnWzCWJO7LVgPcVMF3gBFcTSzGMwH
         QdqDlTGZ2nZtiyRUtUbOpOLWusO1NB7jvLQkU+ApgYrZBwsEKA//aIMWncPKcFlh+e0u
         hi1YAjDVh7iZ2SMdwfatk0QVcfYRu7hu/TB/UP/rQ5K+QyHHUH3K4VVyl+VqrTWnWQjN
         ZEbXRdVOmeiWET+OclhawFUC9Pt1Qw6qrc5yAQwzKbX33hSZeCSZoyr/87bT9BRFI5n2
         py+A==
X-Gm-Message-State: AOJu0YyI3HnzisOqcsnofk4rdFfc4r4oRMVM53dWMxAGyIRrc4U7Tftr
	/LN6w6I7PTPUldzUs4z13Z1TmWmXl8AAMG6pffmaze+Dk5HKhyh7lb6OOEqdKA==
X-Google-Smtp-Source: AGHT+IEpt9Uv771YwNLuJA9hxBAARhf3uGQBrVyf9F01Epq/h6k/cCwGA6ef+W8TDQy63/KEqTvc+w==
X-Received: by 2002:a05:6a00:1916:b0:6ea:9252:435 with SMTP id d2e1a72fcca58-6f4e038539cmr30136708b3a.30.1715885703535;
        Thu, 16 May 2024 11:55:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b060f9sm13399031b3a.182.2024.05.16.11.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 11:55:02 -0700 (PDT)
Date: Thu, 16 May 2024 11:55:01 -0700
From: Kees Cook <keescook@chromium.org>
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, Ben Chaney <bchaney@akamai.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/efistub: Omit physical KASLR when memory
 reservations exist
Message-ID: <202405161154.01864575AD@keescook>
References: <20240516090541.4164270-2-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516090541.4164270-2-ardb+git@google.com>

On Thu, May 16, 2024 at 11:05:42AM +0200, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The legacy decompressor has elaborate logic to ensure that the
> randomized physical placement of the decompressed kernel image does not
> conflict with any memory reservations, including ones specified on the
> command line using mem=, memmap=, efi_fake_mem= or hugepages=, which are
> taken into account by the kernel proper at a later stage.
> 
> When booting in EFI mode, it is the firmware's job to ensure that the
> chosen range does not conflict with any memory reservations that it
> knows about, and this is trivially achieved by using the firmware's
> memory allocation APIs.
> 
> That leaves reservations specified on the command line, though, which
> the firmware knows nothing about, as these regions have no other special
> significance to the platform. Since commit
> 
>   a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> 
> these reservations are not taken into account when randomizing the
> physical placement, which may result in conflicts where the memory
> cannot be reserved by the kernel proper because its own executable image
> resides there.
> 
> To avoid having to duplicate or reuse the existing complicated logic,
> disable physical KASLR entirely when such overrides are specified. These
> are mostly diagnostic tools or niche features, and physical KASLR (as
> opposed to virtual KASLR, which is much more important as it affects the
> memory addresses observed by code executing in the kernel) is something
> we can live without.
> 
> Closes: https://lkml.kernel.org/r/FA5F6719-8824-4B04-803E-82990E65E627%40akamai.com
> Reported-by: Ben Chaney <bchaney@akamai.com>
> Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
> Cc: <stable@vger.kernel.org> # v6.1+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Yup, all good by me:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

