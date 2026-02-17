Return-Path: <linux-efi+bounces-6158-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAW4Lq0klGnXAAIAu9opvQ
	(envelope-from <linux-efi+bounces-6158-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 09:19:57 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB3B149D9A
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 09:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D68D1302C900
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E452E3AF1;
	Tue, 17 Feb 2026 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNq5otfz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B0LG4LiF"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B3D2DEA62
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 08:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316365; cv=pass; b=YwnVMmxdxE01NzJ8ZWaKBjmJ+P59IdWMPp59xEnO71iCNwts9L/51Ikftuf/FVjmzFcnmgJ4Z4U1vUJPshYt6RlmP7fmd+rMQu6t2zWC+ZHQtIyyx5RDN4zEat1NhAU9P/Z9lglygLxpxUSPWE/y1d38e1sJSQ5a7iT3hIKse4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316365; c=relaxed/simple;
	bh=znhNqr/drQqJ4ae4YxqOKS9zjrFK/75HwIzBVCQLaU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVhjM26TCkuWq51P8aiMzXeoVhBJD6WEEZikgANLVqi77uazhsGPka2lebJ3KTxflVzYtwngnUzb4K/k38pZWh6r+SxKY4Jo+kLSzOK0UkXkUvR6cWUorV4Fi4VeJFuomlBgO7byJ1foFmKm5ir2EwyGVUVNgyIh+6aCv67aLgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNq5otfz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B0LG4LiF; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771316362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xfYi7PI9qxM4J7aWJczxJb+aA3YSTrI6zxvigzJKugo=;
	b=KNq5otfzhE7jK130GZv1HJj1FfyZAkza8XEZdyxqhOlnoU+EdlN1TuMUi/GanURAa7rJVe
	zjhFOhMfZR1UtsUMHYYxDWtqJ+Wmo3sHqmIKEDS+xnPbG9kiqWecoq9jasLYf5cOlbyiiB
	ug5f87O/S0j0F+qGg3bqvaZGYh80XNM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-7KozMyKmP2OrH8GfmK7aNg-1; Tue, 17 Feb 2026 03:19:21 -0500
X-MC-Unique: 7KozMyKmP2OrH8GfmK7aNg-1
X-Mimecast-MFC-AGG-ID: 7KozMyKmP2OrH8GfmK7aNg_1771316360
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38710504f15so29042201fa.0
        for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 00:19:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771316359; cv=none;
        d=google.com; s=arc-20240605;
        b=e3cx+/F3wzQGxW0g1YXTWNurzPTeQAj/RBNbyEO4GCz2mAF7CYjbP1fvZdrSXyrQiT
         TBCnXTDlFuZDzGi4d88jQaJba8oaPHX8UIZXkjJtWb1v3jcWKzdqqs87Tq2fSlhg99SQ
         vm/xooAPONJLToW43NFxUtjDvT1szlJ9cFym8LmRefqBXznqzXADptk+67nBbLBBKEP3
         5kXQPCsUOl/6mXCC4haEhZnKo1pTB7gJmDrkS+msKWmm1Y1s7NldNqCSvoDoTepg8EZo
         O09CNzaMie2e0UjPvH3EvLMSfnrBDBmA0oOYCr/SgRqPl30+9X9UCghba4NvNUg5ONGX
         jgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xfYi7PI9qxM4J7aWJczxJb+aA3YSTrI6zxvigzJKugo=;
        fh=G/e/8nSSnyPjsBsyVMWIvFLYC3yGaE+4/NoxrzrupaQ=;
        b=EuSxscR+J2+4RHCGoyuanzK/URbYpHxvV4id0hHsVPI9vuEfcKlHBzeTxv+V6O/vl/
         U2Wy6PCBPt32ubo0WzWf6jjl/saEn2+z6zEFxdEnVV6fmYl8dCm7pA+xeMz228hFWnFy
         3wYDNk7IL78TBsyvk3eRPuVRtItism5J9Qv8hqJNgCOp0rTbF+vSgM9GaWDHBtUhBy0K
         CHuJ4QEAEtIPd0u4HvFe8ufxgkUPU43dJS1+SkqDgK25ipPudoHU2lm0Ccpd833K5ezj
         2/d9nxLuzYY5tBS91keiCFzoFJ3PMnL+M4TTg+ZoZ3chtMZD9g8mYHx4oxui0E8NFh2e
         Q3hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771316359; x=1771921159; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfYi7PI9qxM4J7aWJczxJb+aA3YSTrI6zxvigzJKugo=;
        b=B0LG4LiFnFkGDq6Rg2d0NI8VrvCHulhmCLotv9NGOwMPD7yabnwHvKDWDE3kZ06JAP
         UPO5zTa1HBEDXHBWb6SKRGWGvFLGnK6fqWtmQFilnKDuXMZbFEOpHoYixJ6voYKAOcvT
         PerRaCoD+QqE6nie2k5PisEgE6jAwogfPCnldS9jxaFrvJcbnj414sYkD3FKBTdxwU2o
         1ZfdL2aERWNejmr0i1QHS1JDDgxp7pCRASopRfIKmJXi70BdYfkyOw0MZ/gdrg39/TKi
         z1/oFnh6xOTPHyxtkKVs76uBvX2yaIxE+TV68IJmbdDnx8TjYLIIgXlr8nG7c1wOPkr7
         mYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771316359; x=1771921159;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfYi7PI9qxM4J7aWJczxJb+aA3YSTrI6zxvigzJKugo=;
        b=bF4rHvuCRIKv5lyzXm6z7v9p/Q/8+QjWUIQtabaxgQkLraCFV1VYRS6/riIxEO4Pr2
         OG/ES9mKjkWUvZfTGVMOMIl/nuhgCmAY8hFWZF7b8s5XXNqkgwhRCKkyHB8mEo83h0ZA
         ooFIBcK1gZ6WrlBpRwy6hhI+B88kEaqc5U+/Mr4reDNc6ubKMDPx+xVnwz/ZLX6Ij10q
         OJDy7xQgVDTJhvz863hvsetK2nCY5GCBDnrgv25PdxrGeO/dmkYeoi6nI4FNw8I52o6O
         6tcYXyLMRapzSie1kB9CRx617fSJ/bUOi8WjAfzm8IZGH7GFV/YiW47tRyFPBVP7W95t
         uWXQ==
X-Gm-Message-State: AOJu0Yx7KrM1POwH0m0bIDaxQxg6esb0Z78jy5QAPlUh5r3PfSTFw1vv
	qmscw6NW0f9lLjbuxjifKqY6C/jSiOELhRRmnJrlW8hn+ZGDMaUPYers3yNk1DN8k/3BPHgtqAj
	3rz1ziOZNeMZhyck2bqP8yhsDkOzUxwTFlNYEs9CjQLbG1e/X2x73xYgrK4WI2YrjRe4afHx2Bd
	bxAffDumBtKff7F06+WfBrbctSUHc9lIP0ix3l
X-Gm-Gg: AZuq6aJPO76x+sYFWiL/c7Kriitp0lvV+q6ClrkBQD9IENr2SFiqxK1ZnhUd51ORUUT
	SNl7pUwYGdnZhUj+EZwuLHHbR7TqgEWhqTAmsU+mgynKLIpmFyEvcmT3V7BmINUCD4Eglgye5dM
	wLNrRXqD1Svn40mK4a+EJvERMGFFVv56LPnZpAVDSc2psqogn5aGGilUtDaY7hfK/FZhTQxnH6q
	jU+ufPRP08Tdy7FvK4ZpPR97q3Z60k3sqU6/KC05ikBeSTxtDObhEhqpod8uDvprBVD
X-Received: by 2002:a05:651c:19ac:b0:366:ef7d:bab3 with SMTP id 38308e7fff4ca-38819c700c7mr38337451fa.1.1771316359387;
        Tue, 17 Feb 2026 00:19:19 -0800 (PST)
X-Received: by 2002:a05:651c:19ac:b0:366:ef7d:bab3 with SMTP id
 38308e7fff4ca-38819c700c7mr38337321fa.1.1771316358898; Tue, 17 Feb 2026
 00:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com> <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
In-Reply-To: <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 17 Feb 2026 16:19:49 +0800
X-Gm-Features: AaiRm50zAzOyAQM4NIdbG6YmCuiYZEV_-O5L8qObfrqsfGlmm9wPU8TIm0MG7Ls
Message-ID: <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyoung@redhat.com,linux-efi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6158-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: 2AB3B149D9A
X-Rspamd-Action: no action

Hi Ard,

On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Hi Dave,
>
> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
> > Kernel panic occurs during a kexec reboot when EFI runtime services
> > are not enabled in the first kernel. The issue is that the second
> > kernel cannot find the ACPI RSDP address during boot.
> >
> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
> > However, kernel decompression has moved to the EFI stub for EFI boot.
> > Therefore, the x86 EFI stub must also be updated to store the
> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
> > can find it.
> >
> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
> > reboot will still utilize the legacy decompressor path, so the original
> > code remains functional though some cleanups can be done later.)
> >
> > Signed-off-by: Dave Young <dyoung@redhat.com>
> > ---
> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
>
> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
>

The kexec use case is it depends on the pre-kexec kernel saving it
during boot for noefi case.  I do not have a better idea to do it in
kexec code for the time being.  Otherwise it seems the early
acpi_rsdp_addr was introduced for other reason (KASLR) although I'm
not sure about the exact background:   (Before this the original kexec
fallback just depend on end user to put acpi_rsdp in kernel cmdline
explictily or in kexec-tools)
commit 3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce
Author: Chao Fan <fanc.fnst@cn.fujitsu.com>
Date:   Wed Jan 23 19:08:48 2019 +0800

    x86/boot: Early parse RSDP and save it in boot_params

Another thing is I do not have much time to work on big changes in
recent years, so if you suggest to have a resturcture I have to give
up :)   But I'm happy to do some trival thing during this week as I'm
in a holiday break and I have some time to play with it.

Thanks
Dave


