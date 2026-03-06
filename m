Return-Path: <linux-efi+bounces-6250-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Jw6FmtpqmlORAEAu9opvQ
	(envelope-from <linux-efi+bounces-6250-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 06:43:07 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA28821BC63
	for <lists+linux-efi@lfdr.de>; Fri, 06 Mar 2026 06:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6F693045027
	for <lists+linux-efi@lfdr.de>; Fri,  6 Mar 2026 05:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5F4176FB1;
	Fri,  6 Mar 2026 05:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SNQEI8pl"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D8436D9FD
	for <linux-efi@vger.kernel.org>; Fri,  6 Mar 2026 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772775741; cv=none; b=LNBZL1WZzfupVQZ3H0WsZIfZ/HgW+2Ydp2COdK32AjHw440wn631FFQGOGe+YJMXDiZ5/AZyE2M+J0noisrZe+kmKKDNkvzXJAkaTQPO2b46Gp0c302tSTr2GJ/AYGIIm6XmK3LB/VryPsovkgWuBoiiy/zqmqqi8JGxI0MtnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772775741; c=relaxed/simple;
	bh=lHtClqQODz2/glyZK4vJ7nvGDP7fzlPgPf1O3N4lSZs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pofz+yumIDdjC0ccBeCnT4iywT6YlMTL8Etb5JakcstRDixNimf+B5B+6vOMOq7u6iwyB3RjiJpwJGiJ2Bzcu6pqMVA9hK3xVzXsFzNdfnTiThR0xnv3Y98UHrnrQdtGeP4oWtnBu/5uersnFiwHQra/XhdJPmQgDW3zcWNYj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SNQEI8pl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483bd7354efso115649035e9.2
        for <linux-efi@vger.kernel.org>; Thu, 05 Mar 2026 21:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772775738; x=1773380538; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXuimAwpOjteei+zeJ3XJ05LznjxPAq8p3+xtzsfeMg=;
        b=SNQEI8pll2W2z1N+M9dJzKPobfNuQg/1v+xQrq0XfWh555sEdx8V4GpbIvkDFsmF89
         gbpAqL422/MbXydQbs61yMIkaLlXvyNkh5cJO7z265PcIP1srBvGzjLNALmjOLUHdlPU
         uT3BV6N8wsvngHVxVgS2hDb10hEFl6QannVAJpWCM43XYnhzCgZkE9uTIAPkqH9IRB0J
         b8429z0msj6VvMUW/Sz+gahldsFUNcBc/7Bh3sNbmmeGuIVYq9qOTH1xZQeHGQO5PKF5
         OYPUfSpd0thXPus4Mp6zLGwCfR6ZVwb9yS2jR+V5yoVXUr2nw2X/7oW2pxJfnuxHop+S
         ixlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772775738; x=1773380538;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXuimAwpOjteei+zeJ3XJ05LznjxPAq8p3+xtzsfeMg=;
        b=FJe0GrqKDfpNojDiCVRsIOSFNiIVgr0HZqpPGldG4x8ie6tDl1VdmkDHoD7gZKqxTs
         8VoIS6GnCgw7xSdt+/b2u1JXpNIEHOLAifvGDOdIli4XfvkHdxqsiIrW2x8RBRMhWiCO
         0QwUUqfu5MEYJT+JNX47SdQnK09dZvsvpM7uZp+NdzxO1VaZj53jJpXHbZYqUBl1vSk2
         Js5XuFIOAwa7VwjHVhO/ClqKcMF5A3f55WpSsmXcHms/FtMjo94pMihGXFvI4GeluimB
         Eq+CzSSKwKMaRE1z0EEGkmqlw3oA89M7DrUp5InmUboP8Kd8jReMS9pu0NNwN3UgHan1
         ZBrw==
X-Gm-Message-State: AOJu0YwSwDuqyxEgQUWs/5C1ZYhMhRezPCQL++TnYz+4UEgexcdRX2hU
	m4hSl6kGPNCjLKoa111p+B5byPjxCoNfZV1AcHVvyez9W7HE7B9jUZU3YqrdAYVNyY0=
X-Gm-Gg: ATEYQzwu9z3JPVdVr+/2XqY3kw4uTQ4plPclAOb0VU5sQ/lCLD7eiC0uMahyuxDgqhX
	+NOahKDxiL8bvvHiPLByzTozjN02YOFNtC1auPhxQeIvkDZk7sVUd/iqZCkIWUbcn9r1PBA7GJ8
	sGMrWbhXBw6ofmJDYxC8u1Tk/joE5JKfIanr8EtEHf3iX+RsZ2e6dDJO9Pu6Y6btDjQh8lV0io7
	yEN8JAuWtUR8ynPr+QPdNmmzwa68hzk3hUseYy8lNSITLk5P2KYnYH/NfPKjf6I46vWQk4Y7Jn9
	ebBnlrfcKdJyw4RdE6qBvdJam4DPR0H9xhoIaB548FgvgS+lnfNT2P/A/Rm0JntdJNYG16MPePn
	nYNC3gQgshoGzc6Md7gLbsxgIpvwB26BeA4EsDI8ZxkvGxTAA3HMbHkYLCW5pvBllxnf1nWbkOx
	PTJs7RAKhXjdBGjBrNDGrN1Qb6/dzhH+kr5LodbI/L7ZE=
X-Received: by 2002:a05:600c:4ece:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-485269305a5mr10886455e9.13.1772775738190;
        Thu, 05 Mar 2026 21:42:18 -0800 (PST)
Received: from r1chard (1-164-74-26.dynamic-ip.hinet.net. [1.164.74.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48648d9sm458470b3a.31.2026.03.05.21.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 21:42:17 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Fri, 6 Mar 2026 13:42:12 +0800
To: linux-kernel@vger.kernel.org
Cc: linux-efi@vger.kernel.org, x86@kernel.org,
	Ard Biesheuvel <ardb@kernel.org>, stable@vger.kernel.org,
	Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH] x86/kexec: Copy ACPI root pointer address from config
 table
Message-ID: <aappNDfdssz9WuGc@r1chard>
References: <20260217163532.5166-1-ardb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260217163532.5166-1-ardb@kernel.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Rspamd-Queue-Id: AA28821BC63
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6250-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richard.lyu@suse.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026/02/17 17:35, Ard Biesheuvel wrote:
>Dave reports that kexec may fail when the first kernel boots via the EFI
>stub but without EFI runtime services, as in that case, the RSDP address
>field in struct bootparams is never assigned. Kexec copies this value
>into the version of struct bootparams that it provides to the incoming
>kernel, which may have no other means to locate the ACPI root pointer.
>
>So take the value from the EFI config tables if no root pointer has been
>set in the first kernel's struct bootparams.
>
>Fixes: a1b87d54f4e4 ("x86/efistub: Avoid legacy decompressor when doing EFI boot")
>Cc: <stable@vger.kernel.org> # v6.1
>Reported-by: Dave Young <dyoung@redhat.com>
>Tested-by: Dave Young <dyoung@redhat.com>
>Link: https://lore.kernel.org/linux-efi/aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com/
>Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>---
>Unless anyone minds, I intend to take this via the EFI tree as a fix.
>
> arch/x86/kernel/kexec-bzimage64.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>index 7508d0ccc740..24aec7c1153f 100644
>--- a/arch/x86/kernel/kexec-bzimage64.c
>+++ b/arch/x86/kernel/kexec-bzimage64.c
>@@ -313,6 +313,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>
> 	/* Always fill in RSDP: it is either 0 or a valid value */
> 	params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
>+	if (IS_ENABLED(CONFIG_EFI) && !params->acpi_rsdp_addr) {
>+		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
>+			params->acpi_rsdp_addr = efi.acpi20;
>+		else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
>+			params->acpi_rsdp_addr = efi.acpi;
>+	}
>
> 	/* Default APM info */
> 	memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
>-- 2.53.0.273.g2a3d683680-goog

This change is good to me.

Reviewed-by: Richard Lyu <richard.lyu@suse.com>



