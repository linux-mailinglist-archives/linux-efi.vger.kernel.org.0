Return-Path: <linux-efi+bounces-6032-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNtWH3MQdGnF1wAAu9opvQ
	(envelope-from <linux-efi+bounces-6032-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Sat, 24 Jan 2026 01:21:07 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9387BA63
	for <lists+linux-efi@lfdr.de>; Sat, 24 Jan 2026 01:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 168D0301A3B0
	for <lists+linux-efi@lfdr.de>; Sat, 24 Jan 2026 00:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABD1A073F;
	Sat, 24 Jan 2026 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gPqAskv8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cywcp0Nf"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28BD192590
	for <linux-efi@vger.kernel.org>; Sat, 24 Jan 2026 00:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214060; cv=none; b=UYmrsL8/xNE5+haM2f9MuZMqm3CDEl1xtuuDQNm4jtMdSSNBH3oRh8uUZO3CP5HC1ozdCYfVfvhI9NVSQJFBropIwFY1F/UdSQaYJ/hrLIPWnyTUNURG6jKqTdFL33EIRNsR2HDLwAawjLYng9IxsEDtWcj7v2tvXz+3WaF3XmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214060; c=relaxed/simple;
	bh=j2cnf66j7Tyeo03Ht3nxIfKsvE0nQ1mv6D7kqhjkBJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VIQOXC22fE47Z7lDvoNKeCOcP1ivrEckHhFNgq/nIqJaG7CuXBUPI2Ns5cYX4Bg9PTcsjfg3/HZI0X1bYb5QNaZjdezW8zN+0zRG9eKY9Y4QYxqGC6a3Owxh0aiXPyHL59DbpZT9b4X2h8H30dU4v2Tb74v0684cFW066M1ewe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gPqAskv8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cywcp0Nf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769214056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
	b=gPqAskv8/iuAIelkAE02Mn5AzPTZq+2afA8ZwLjZq6cnB+hM2uk9a5HD1oPkITCfuYbXHx
	+rKoOhUta5LfNYV+2z8Yy3XT9ueZYtv3n+bT9J9aGBcAaf6Ew1rZaPWdz+E0FLTZKK8Q/b
	2+LbOmXOchBuzQEPEdQ8Dlt75VTeVJw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-rmQXqQDtN7-6EN_LYOrPww-1; Fri, 23 Jan 2026 19:20:55 -0500
X-MC-Unique: rmQXqQDtN7-6EN_LYOrPww-1
X-Mimecast-MFC-AGG-ID: rmQXqQDtN7-6EN_LYOrPww_1769214055
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a78c094ad6so24961125ad.1
        for <linux-efi@vger.kernel.org>; Fri, 23 Jan 2026 16:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769214054; x=1769818854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
        b=cywcp0NfT4qTxGKtlk4pEqV6LpdD2LHnGGFpE3nSVwX6aejnZN0oJvvH7X6ppckev0
         NmqEYd5Khy+qEN6tU3NtowvlifS9f5TYdQSBjOcsQCcGVc+RmvKDumIaEQEhJWwINLex
         hhqAjZWSHn2PTSZq4GxgEPdbo8qOPEufVWkNR+R+QKN3IAaysiZ/wfeRpsWD12D/pC6n
         V1+30S6cbMs94/493Z85O0QCOG2NdQRTmD8cGu5QS44aZeHChCfDkXOGWnPFH4fo19mb
         xdBm0R0HwUmQUWcLNVMGErySfUJtRKE2LcPVRXO1kGLdRVehd/EA0YoR5sOOoRjQmZca
         8AXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769214054; x=1769818854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhgLPiYR6xEsxXnQ/SeaMjXXghHvMuOe7YsndhfrobA=;
        b=kbm/mp9+JYhDOvoYnOaNjX5i2PM789BsRTsJ4omEkOR/+5vAhmHG3emfrNcLLR4QAx
         ePUtJavy4V6kJcszM/TX4koTv0EXWgB4L/R/0nSDb7Sdu48DoGy9Uy85vtDCX46ME5b3
         T5mcvUu4/fNXHj3maA7Obq+XREQZnLYNhpnzzpMUJIhfi3zuWcxrwFjoMzVnixo7C2RI
         luUpW9iaeX9AJkf/aoV3cyb3LtlJpYcl+WLDd3fZ+s6vX2iMvcrAk6TYbnJK7VnQBMSf
         VPtYuBpgr7FAYjvVwTKtJd97SDAATSZpJ5QdUNFgKZYxh2K3FrqGFYlA7pZ+KdV3UhNd
         pDuw==
X-Forwarded-Encrypted: i=1; AJvYcCWjSevDRT9VmMKLqRKiUGiIN1jey/pBxNguCRgHESsUrKkA11WjwCloT/wk7TtdXdA2u+qtT0BvVLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNzZuqzd0yJasnosIpncsVgVv6PoZonkGNXWeLNA/ZSDUobssM
	GygWGr9sERTjwfXIhickVritllU6JZWfJkCmgFWvUjJDtVavKHUFFvs4C3tSxV/SGlGqpK9HHNr
	zthcwJA1ov7MSiIud2/8QO2JagBPZgYuLeoqEl16RPQHvOfrCSpvLrNZL6q1ilg==
X-Gm-Gg: AZuq6aL8lp2vGRhKoUcOqihNOl3WyT89zRCGaJAtlsdNfoAnfjAQEJ5hq3uSNDdT72W
	iSngwXlu4uyIhXC3VTfPf/OOXPdIcQ3wCWW+Qge959aIhKwymvjE3lIWWy9deEJKYoXFhx8czma
	OX23kDnIY5RltALNn9LRtSdbeohcd+yFrzVMX6Uo+EVrunfECyDc/4UH5j4xatohW0WFzpKLiLt
	LeVgTPCDXgD9OheAcAwsgxbt1z4tJR33vusCD2tMAvQ/cAV2urBQFHNNRyyxFIc0dodNJUbrXdG
	g0p6WwqlLeZ9eSKkvODuyNeXpgQdrCPGaWLZYKqRJ4vk6wtZK6nucd2m7Ps/H+gelXBb9pOcZkW
	/
X-Received: by 2002:a17:902:e54d:b0:2a7:682b:50ac with SMTP id d9443c01a7336-2a7fe625118mr44257495ad.28.1769214054353;
        Fri, 23 Jan 2026 16:20:54 -0800 (PST)
X-Received: by 2002:a17:902:e54d:b0:2a7:682b:50ac with SMTP id d9443c01a7336-2a7fe625118mr44257045ad.28.1769214053812;
        Fri, 23 Jan 2026 16:20:53 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802faf6f9sm29695045ad.71.2026.01.23.16.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 16:20:53 -0800 (PST)
Date: Sat, 24 Jan 2026 08:18:46 +0800
From: Coiby Xu <coxu@redhat.com>
To: Ard Biesheuvel <ardb@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-integrity@vger.kernel.org, 
	Heiko Carstens <hca@linux.ibm.com>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>, 
	"open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" <linux-efi@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
Message-ID: <aXQN-ZNhT5olbf6X@Rk>
References: <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
 <aW2i3yacr5TvWU-m@Rk>
 <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
 <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6032-lists,linux-efi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,linux.ibm.com,huaweicloud.com,arm.com,kernel.org,ellerman.id.au,gmail.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.infradead.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B9387BA63
X-Rspamd-Action: no action

On Wed, Jan 21, 2026 at 05:25:39PM +0100, Ard Biesheuvel wrote:
>On Wed, 21 Jan 2026 at 16:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
>>
>> On Mon, 2026-01-19 at 12:04 +0800, Coiby Xu wrote:
>>
>> > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> > index 976e75f9b9ba..5dce572192d6 100644
>> > --- a/security/integrity/ima/Kconfig
>> > +++ b/security/integrity/ima/Kconfig
>> > @@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>> >   config IMA_SECURE_AND_OR_TRUSTED_BOOT
>> >          bool
>> >          depends on IMA_ARCH_POLICY
>> > +       depends on INTEGRITY_SECURE_BOOT
>> >
>> >
>> > Another idea is make a tree-wide arch_get_secureboot i.e. to move
>> > current arch_ima_get_secureboot code to arch-specific secure boot
>> > implementation. By this way, there will no need for a new Kconfig option
>> > INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
>> > concern.
>>
>> Originally basing IMA policy on the secure boot mode was an exception.  As long
>> as making it public isn't an issue any longer, this sounds to me.  Ard, Dave, do
>> you have any issues with replacing arch_ima_get_secureboot() with
>> arch_get_secureboot()?
>
>I don't see an issue with that. If there is a legitimate need to
>determine this even if IMA is not enabled, then this makes sense.

Thanks for the confirmation! Here's the updated patch
https://github.com/coiby/linux/commit/c222c1d08d90ef1ec85ef81ece90afc9efde7937.patch

If there is no objection, I'll send v2.

-- 
Best regards,
Coiby


