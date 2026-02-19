Return-Path: <linux-efi+bounces-6185-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7epbBhW6lmkLlAIAu9opvQ
	(envelope-from <linux-efi+bounces-6185-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 08:21:57 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A188415C9F3
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D57A8300AB3B
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 07:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93B52F7445;
	Thu, 19 Feb 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J026NxZ/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37982E54A3
	for <linux-efi@vger.kernel.org>; Thu, 19 Feb 2026 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771485713; cv=none; b=BPG6PPix3ciMUZ7Od5nEKSAh1QPqjuDWRaN4YLO1KfmUhM463yB2L4FeVv9Hd4Y0iLW0cHrIeyW/yYCoNkrxMuo7241ez0ErTzXq2Je6ymPRdd6h8h1fjFqcIDW98NXHv/7aQXcVFyvSFArLjwmlpwPd44804z2RxLw5arzuUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771485713; c=relaxed/simple;
	bh=Ou7ySdIQWXiWriFhR45WVSxPkt1Uy+MKznyhuxQi4Xw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OEAjop4soH/K/oLbN6Cjs95ibE5TlLSa23mTNnQcKQ1X1QjIUuegBr4F1LdN0h1dEKIgjYtLnUS8VMGZwDkfJFF/MGKtopIdrI4JnJdJm8wMjgc/gUkvrYDKl5zP8QCMcmPaP/yJwLqSvCCTTmm1FD2kBZOmVxLSF1o8BzKYoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J026NxZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D5DC19421
	for <linux-efi@vger.kernel.org>; Thu, 19 Feb 2026 07:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771485713;
	bh=Ou7ySdIQWXiWriFhR45WVSxPkt1Uy+MKznyhuxQi4Xw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=J026NxZ/M+/EY78DJPC9oteKnlkywHGpZhT671e9QNUAp+tvHhYlMs/pbboHp0bCO
	 +ReP64FhPe8tCYDftBv8x8Y9+jFp+OqkUo+GCRpZQs5V6X3E0AXchT3AZH19eq9w2i
	 enPwafPewNppXqONfa8nMQufAEErHKDK1z0bO2tHWT6JSUKaSmNiz++UUdfEY5Iv3a
	 0b9XYtMm9pyQjsGjjk2DwdzoHXWDdTX599GeRCn7cZ/wJxvVpCzvg2O1+YZfnHn1j7
	 MeMswB3HHYO07dOLVl5tX9Dj6mfjsv+XSj3yAsryloUkLilFcJ4Sqel1lJmupNKVhN
	 ZqMfVs4dtI4TA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05773F40068;
	Thu, 19 Feb 2026 02:21:52 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 02:21:52 -0500
X-ME-Sender: <xms:D7qWaX21y9gFPaTmzqLWzTBoS5nCiy5xv_Wvk0l18hxhGySOTb97dA>
    <xme:D7qWaQ5oleQVyebjta6lLkSnTDtYURScr2l56z6_Ngl3Xqe_NE5BHBhkxO4LHi1_X
    lYh2avwdAEY1CXT9E2IhDZgcr-3LC30rPjiTaftqXbYcRYCssNqog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdegleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvgigvggtsehlihhsth
    hsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepugihohhunhhgsehrvgguhhgr
    thdrtghomhdprhgtphhtthhopehlihhnuhigqdgvfhhisehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:D7qWaTLbTuz0Dj6d9-BPmauH-eFSmR_KWwjL4gX7KPlqLbd_USPo5g>
    <xmx:D7qWaa2BC9zcxDj6xG4pKJ8H6y-UFSU0BhAHguxzrK3sW5QQy7osKQ>
    <xmx:D7qWaVj_puEdjRoz81T4WT6rKcPrmqSG98WXWnSW9YHzRqkcaOUXpg>
    <xmx:D7qWaTU4kbZS-TLjxxZdSR9ZO4Vi6dbkZQR3bR1dEdDIz86bm9Y1tA>
    <xmx:D7qWacVbpmH-UPF7gWUu5xNm29cDs-Z3XyF4JmL3pBygEA85i0oQCCw7>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CB2AF700065; Thu, 19 Feb 2026 02:21:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Thu, 19 Feb 2026 08:21:30 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <7c10262c-b320-4e80-b92b-107b693a928f@app.fastmail.com>
In-Reply-To: 
 <CALu+AoRdx_=FFkFUcfwc8Z_7qmMbyC6Yf5AJA6PpTyDcjBS2Hw@mail.gmail.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
 <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
 <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com>
 <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
 <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
 <CALu+AoRdx_=FFkFUcfwc8Z_7qmMbyC6Yf5AJA6PpTyDcjBS2Hw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6185-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A188415C9F3
X-Rspamd-Action: no action


On Thu, 19 Feb 2026, at 07:57, Dave Young wrote:
> Hi Ard,
>
>> Actually, looking at that code more closely, I kind of wonder why the kexec code tests for EFI_RUNTIME_SERVICES to begin with. Perhaps it might be sufficient to do this:
>>
>> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
>> index c3244ac680d1..bec91ee7e668 100644
>> --- a/arch/x86/kernel/kexec-bzimage64.c
>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>> @@ -192,7 +192,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>>         struct efi_info *current_ei = &boot_params.efi_info;
>>         struct efi_info *ei = &params->efi_info;
>>
>> -       if (!efi_enabled(EFI_RUNTIME_SERVICES))
>> +       if (!efi_enabled(EFI_MEMMAP))
>>                 return 0;
>>
>>         if (!current_ei->efi_memmap_size)
>>
>> That way, if the first kernel was booted via EFI but without runtime services enabled, the kexec'ed kernel will simply inherit the ACPI and EFI tables.
>
> Actually it does not work,  EFI_MEMMAP is unset in function
> efi_memmap_unmap() when runtime is disabled,  so nodifference for
> checking EFI_MEMMAP or EFI_RUNTIME_SERVICES bits.
>
> The x86 kexec efi code is simply written to assume EFI runtime is
> enabled as it copies the cooked runtime service mem ranges in memmap.
>  If we want to improve it I suspect the efi initialization code could
> need changes, and then even if first kernel disabled runtime, the
> kexec 2nd kernel still have chance to enter virtual mode to enable
> runtime.    But this does requires more work to be done.
>

Yeah, fixing that seems a bit risky, and not really worth the reward.


