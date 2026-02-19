Return-Path: <linux-efi+bounces-6183-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNrNATe0lmkxkQIAu9opvQ
	(envelope-from <linux-efi+bounces-6183-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 07:56:55 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD115C8A5
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 07:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8EE7F300406B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 06:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99AB326920;
	Thu, 19 Feb 2026 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzZdm5mY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NnTijxEq"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6078F325729
	for <linux-efi@vger.kernel.org>; Thu, 19 Feb 2026 06:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771484208; cv=pass; b=M7MJyTodXWuXvWKNlLByvtAkCa498py8kl7epVZpxwL03itzHvYOgJanDvd2nhWhYkezfCXdsrnyGDXd9c2MveK41xvOL4BJsjw5Ege3/td3aL6MUfUqvK+WzFd9SxnP+54+L+UIhlT2Fju/XU+brdz8d8ixdMOs7cWfUZpH50w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771484208; c=relaxed/simple;
	bh=kKsAkUzxdXxux1V3eUxXjbj65mVUwB8IK1DK5gGJIVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyKRtMDSwhQaRPE6UMHrrpSq4XlemgsDXyMyOLCMZ45UtZ+tXpv4vYc/FlfY+0TlIUh3W4QhWNJrpd1a3ZcN7yFW3Oz5HBanYDWaMCy2acT0CSLo6zG1lwiOdPz9StPLCDvp7yxqcrXZbrvxGaAow1F3ot1+x/rmtpktuyungnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzZdm5mY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NnTijxEq; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771484206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f5Y/ObMYOjMNaMYn2BS529u3eaizGhMbHv9x7KJjXe8=;
	b=FzZdm5mYJTSCdh9SBAR+kORCAb9tbSPNR7EtP8p6CbREQYU4UZllTyzSIwIB3NMtiQagLa
	C6ckbh+IvbbUAnJYGVEzPkoaeNJpsuPGY0S1lRJZQH4YqMb9/TVBd1LUMrZZh8XXkhMqT9
	OV86FrtG5asJOJTA5rxGzhRdgi5fYDw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-ZVJeQDs5OlmtAmVkvPyZkQ-1; Thu, 19 Feb 2026 01:56:44 -0500
X-MC-Unique: ZVJeQDs5OlmtAmVkvPyZkQ-1
X-Mimecast-MFC-AGG-ID: ZVJeQDs5OlmtAmVkvPyZkQ_1771484203
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3870af26404so3067171fa.3
        for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 22:56:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771484203; cv=none;
        d=google.com; s=arc-20240605;
        b=W4qjpb/DqEKuTpcs7j+NW7ZQLAy/LHrx0HeHHfXrHNKo6nL2gPsUaZam0b0c9hJpcT
         P69wHI3GIpzh5MP4fsVhQubP6WrofUZM8pTaj05ZUQRI4nK43cF+ekQGmPFkHoUIznv1
         1+fCdaajfZjrRZH4d6j7eXbTd6o9w+7JvLObneLQTtt5vEBGJkNUWmeenBwqFBiEWOQ7
         a/hhNJ4XZ3PALbK+FTj6YJOglG0t4SS/RnKR3jXvEnaRhonafUTHXfAL0XZdgZ24u5Ro
         RqmfUt6jWVJoGgdKO/HeYcRdR9I5iaqbofVge9SPLp60kvEB1lzAMYWdG76wya8to+TY
         BnOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f5Y/ObMYOjMNaMYn2BS529u3eaizGhMbHv9x7KJjXe8=;
        fh=G/e/8nSSnyPjsBsyVMWIvFLYC3yGaE+4/NoxrzrupaQ=;
        b=kpDfBUaWGflyRnHtJw9utoXkgYWgd3sodkm40chxu+jiXrfWzTPDYRSz/cPonHuFst
         0lVdEgD3I+azPHTiOR2Vt2/8zePmThd8w5jKFe1/hvkygVZ0bmMhwfcKhNOG1CKSnZ7f
         H56+HU7mF9vRpjYgw9rKn2boyoBxSuZ2q/mOKpqUZeWEpOBc4kBrxeCBm2Pa/nrxp/rJ
         UCSQgLNyOUyQitw0wzS0BHAc65kU4ztoI+s7Y5pWuRhBBVE24KBHBKiQvlFA0tc0dHE+
         8+wPZXNXrIcoPdaf6KtQfV4XsRh20n9e2+zNWuH0Rzl8wk0lhFQXF3J6zYD4MhEcg23E
         ahXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771484203; x=1772089003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5Y/ObMYOjMNaMYn2BS529u3eaizGhMbHv9x7KJjXe8=;
        b=NnTijxEqvxtfiPge0m8FHIR2NHvrvcqFKlNd2h8KPI/UrUAzcUcJDU2aWCn0rldmmh
         7wn42oFwtMpQBlf/4oUTizXOpCS44EltuoCso6q+ASTnUuMN1dOTaeKOBK3gw+2wDczH
         PU8LGblc8VzMHLxtk+QFNTRSKLOiFbPlI5QEQuCf9CwDizb7MDnjLyjZpsHXz474idF0
         Q+GOet/voeBhWlsY1ZnLgDTHc9HEW6uEVhfEQNZmJCVW/cBagJLgd1J8qgjUI6JEwK1C
         ong38ivHmxqwBkf4oXOKs0MezhC5aYOETKdn+smBVX6EFLsyBLU8ZuKscUF59i9hvbme
         /rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771484203; x=1772089003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5Y/ObMYOjMNaMYn2BS529u3eaizGhMbHv9x7KJjXe8=;
        b=tW3AT0eQLXxrKircXO/DtAv3esLslubtJ5TYmcxzfZa/my55Y8Ym3/4mdkdusncwoG
         7tfBlnY+tA4yI4RER4grBRzDhBx5q5eEuCpQgA/F1DQ2gV4SrPoArTZD/Q4wdPqG+Ob/
         T4Npq1a8K54e31EdRBUJw9tp/D3LsEoMy71IFsGGup+gWJk8kTTWErcjeSCXp1cFitna
         CnlgGOYNoFvYxd+lzomhNS28J53EY/2LfnrjWkdRAQ7eltCP9o09wqB0/1pDF+P6cWYZ
         d/jczPpZDD26ajiQByGY7YUkoTs5/sov+dHQqNBAc/N9DpFdpEWO5DAnYUXRecmR4LPA
         pcCQ==
X-Gm-Message-State: AOJu0YwUMFaoCfh/UQH0MV8DBM3vik0YDNm6fbpZPUWos5WTnJPjnCYy
	4g4tcxJqNY96KYrjqIYir1pL41dtVYeMZEuBieeR3NH8/lbPJtpsfZYZeJfdJOBQwEb0gZyWYyW
	VQ278q/BmrgJmvj0L0ZsXCba6t9sSgtm+4lgsX7oFVAiHtdYSvjFSNw7xV91xSB/OKnFu10ChV4
	c1JkxvZcFHxhqIvh8QGRW/W24VZio5TpLId2qh
X-Gm-Gg: AZuq6aLsknkc+5jccr2Bg1TVGdwESa6SdlWurQHbBCyj9ylahqOSYjriJsUqpIpo9hS
	2UKuOIuhDmD+6XabwafrVg6EgH7ESDMFHbCoQBK7sJQq7IHePpuiB9IC122PVTBpKnisDTvzjxO
	eWhT2Votyntwvx2TWwp79RqUI2FRG1yRHtGWPsoOO66+3RRaVZrnA9judtm+Mrb+EseoBKS+OL3
	+FeJZZ7EDdjmLUDodt7LWj5FGcLVPf+1RHN1uLNuTjH9byI+UWhy8PGv124vocBJyqJ
X-Received: by 2002:a05:651c:2225:b0:385:c13b:5584 with SMTP id 38308e7fff4ca-3881b97e9a0mr51039951fa.36.1771484202699;
        Wed, 18 Feb 2026 22:56:42 -0800 (PST)
X-Received: by 2002:a05:651c:2225:b0:385:c13b:5584 with SMTP id
 38308e7fff4ca-3881b97e9a0mr51039911fa.36.1771484202292; Wed, 18 Feb 2026
 22:56:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com> <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com> <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
 <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com> <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
 <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
In-Reply-To: <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 19 Feb 2026 14:57:15 +0800
X-Gm-Features: AaiRm52MPDjJIrnr6aiuB7naGrInBNXWrag7kRXeZTmUUl0RZ8Q467qwTU_SJBY
Message-ID: <CALu+AoRdx_=FFkFUcfwc8Z_7qmMbyC6Yf5AJA6PpTyDcjBS2Hw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6183-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyoung@redhat.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2BCD115C8A5
X-Rspamd-Action: no action

Hi Ard,

> Actually, looking at that code more closely, I kind of wonder why the kexec code tests for EFI_RUNTIME_SERVICES to begin with. Perhaps it might be sufficient to do this:
>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index c3244ac680d1..bec91ee7e668 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -192,7 +192,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>         struct efi_info *current_ei = &boot_params.efi_info;
>         struct efi_info *ei = &params->efi_info;
>
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES))
> +       if (!efi_enabled(EFI_MEMMAP))
>                 return 0;
>
>         if (!current_ei->efi_memmap_size)
>
> That way, if the first kernel was booted via EFI but without runtime services enabled, the kexec'ed kernel will simply inherit the ACPI and EFI tables.

Actually it does not work,  EFI_MEMMAP is unset in function
efi_memmap_unmap() when runtime is disabled,  so nodifference for
checking EFI_MEMMAP or EFI_RUNTIME_SERVICES bits.

The x86 kexec efi code is simply written to assume EFI runtime is
enabled as it copies the cooked runtime service mem ranges in memmap.
 If we want to improve it I suspect the efi initialization code could
need changes, and then even if first kernel disabled runtime, the
kexec 2nd kernel still have chance to enter virtual mode to enable
runtime.    But this does requires more work to be done.

Thanks
Dave


