Return-Path: <linux-efi+bounces-1695-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3D3973D01
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 18:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304F51F21F4F
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 16:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A1219F470;
	Tue, 10 Sep 2024 16:09:35 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0D12AEF1
	for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 16:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984575; cv=none; b=O5iZkpkrSjFcDOrioVkWWeGmZaM80Xe+SEkr0dIxxeApxcb+K+rjTf9L3F3rn3XGnieS3ITyYabKI4vTIOY8aFuqN3lmgflRL+PlV3YK8oB4kf3jITNkj3+4M1rIIEhvGeoj/ncxqHq0NaqYHDMQXrUaEksdBFu9FibhJK9fRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984575; c=relaxed/simple;
	bh=xHR4rJSJQw3tDubjivoBVDFw25DHvJkj9Y2thQDy2as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3l9757TG75y+nGwnQh1NPvxPnIEDqkOnWgbdRPbCopZbw5S8y7RfBtXxMyFZ3MSd1gIwtwbLxPdodLgut1KOGyG2MX/5oq6anA9zzzehFIwlvsfGs2Bg6EOQmMyxpYqKLqqlFGaMngnLfq6K3vNpvJqohk5GvwYq46Ku0VWQyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8d4093722bso7471866b.0
        for <linux-efi@vger.kernel.org>; Tue, 10 Sep 2024 09:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984572; x=1726589372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OICN9yWXeUKoIzpkf47HqdysUCLiFXPVEMv35d7OftU=;
        b=r2Fo3WexJ2s6VAF2DEsR5VPOLmL4+X2xaRTfRVB37NlDAIEP3uMh4YsTQOcx3tffkX
         kGwKjfiwBgxaE4D0PnmEVE/3f0nXl+eWDCEDGqncuVt2X6ees+f6A/x4CdYhbGrPMZeM
         q237IJch7nXNnsZImlxPJRAK3lmbx32qLHAig89DQk3XZLibTLZQYYq7zQBoLZX6yJl/
         OUJU89tOKmmOcgQm9qTyHifCSlBVlPCuaITvbWLV4R3Ud51/wx8PkbFG7W6FWlmPm6V+
         fUEv2vZ0s+eEho+HNa3CrCpIHt5Gu074dpIQ3/pZq2ZDKx0M22tBVjWUSp4QxIWLwsAL
         iQGg==
X-Forwarded-Encrypted: i=1; AJvYcCWG3HCan80iQkVQqCtyPTT1AbgFU1eH8c2PRBST4/EJY9qkW9FctE0qA8OSgE2iVaLAixPF4Q5strc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx76bQc+NWJJJycmm6stfOqvT+dQCsDANwpxNgSlBVlhlQI/1rG
	qs42+0YzDOMcURK25VxwgnmIHHB1i0FI5icLt2htmOo4Lll5Uw5t
X-Google-Smtp-Source: AGHT+IGNrkxiR+3Iqt74NRnDw9jegrN1LNQi6QH6ygQSAS6+yyvwbVZ0/uE5DBfWEfyrmIMzBTFiUQ==
X-Received: by 2002:a17:906:730a:b0:a86:68a1:6a08 with SMTP id a640c23a62f3a-a8ffab8346amr133085166b.29.1725984571286;
        Tue, 10 Sep 2024 09:09:31 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-116.fbsv.net. [2a03:2880:30ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65742sm497575366b.216.2024.09.10.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:09:24 -0700 (PDT)
Date: Tue, 10 Sep 2024 09:09:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Usama Arif <usamaarif642@gmail.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, ardb@kernel.org,
	linux-efi@vger.kernel.org, kexec@lists.infradead.org,
	bhe@redhat.com, vgoyal@redhat.com, devel@edk2.groups.io,
	rppt@kernel.org, gourry@gourry.net, rmikey@meta.com,
	tglx@linutronix.de
Subject: Re: EFI table being corrupted during Kexec
Message-ID: <20240910-strong-dancing-rottweiler-aaed51@devvm32600>
References: <20240910-juicy-festive-sambar-9ad23a@devvm32600>
 <87ed5rd1qf.fsf@email.froward.int.ebiederm.org>
 <9b024f7d-e326-46eb-bd88-71a16151fcf0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b024f7d-e326-46eb-bd88-71a16151fcf0@gmail.com>

hello Usama,

On Tue, Sep 10, 2024 at 04:46:15PM +0100, Usama Arif wrote:
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -60,7 +60,9 @@ int __init efi_tpm_eventlog_init(void)
>  	}
>  
>  	tbl_size = sizeof(*log_tbl) + log_tbl->size;
> -	memblock_reserve(efi.tpm_log, tbl_size);
> +	if (!memblock_reserve(efi.tpm_log, tbl_size)) {
> +		arch_update_firmware_area(efi.tpm_log, tbl_size);
> +	}

Shouldn't you reserve the region into 8250 independently of
memblock_reserve() return value?

Thanks for the patch,
--breno

