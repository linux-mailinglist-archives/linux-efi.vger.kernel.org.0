Return-Path: <linux-efi+bounces-6159-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uB40HeQylGkNAgIAu9opvQ
	(envelope-from <linux-efi+bounces-6159-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 10:20:36 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A02DF14A4F0
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 10:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 219203004D36
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD333033F6;
	Tue, 17 Feb 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGGBNNBX"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A11327FD76
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320032; cv=none; b=nvLSQ2YmmCVn8jMxZQwPhUXc9/C3VzMiHlV0NN+2qRTzzmYq8pojePh+KV5aVeYtPqns9PMsbGWcOpSnRzj3jsQnTSYZsk5ocY9BGs7OLN9OCJk9NepIxNCFcgJt21zd4b4aI8seBLgV5BRIcCtTU1XZiEMZCgnuT6BQXkxSGHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320032; c=relaxed/simple;
	bh=m77q98Ca7HhJMMoYJsCKLdXVsY8u/UjfHANHKEYGBjU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CAq0G8c3SYCo4/YKdS3yW5/sbA7c8x8vRx8BSfaU39ITe/46tBKHXnyLH+FZM82qu7jculVnM9AXYXCEDULkD5ofttA6oE8gTgKvYoUHwIBogA2MV7XCJJgRi5J+Zq0rUtkJ/OEYlmYj7530mg/igy70GNkit+MAn+TacYcSN4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGGBNNBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDD4C4AF0B;
	Tue, 17 Feb 2026 09:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771320032;
	bh=m77q98Ca7HhJMMoYJsCKLdXVsY8u/UjfHANHKEYGBjU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CGGBNNBXOLJ/IKmOnYGdIg8cu7qzhe4CMaZhSxS/SxMomha10+xE4y0jb3bYbfv2l
	 nGRaKps4sGbyEJPmn0r7HekV7HPyFh1Zq2mklLVp9mgfiy5NV6BcLSNEmDRRqIc8y6
	 CPbNh3O1Un4BnE/63VfO4CPJIJ+incMK+7onmrE52aFMSjwp7/owD1EDqPHH5C4PuD
	 N0vKzuxa+2Vte/vMZ8zvJCvZCNVPeclBYMXCbtvSIPLWF51Si0Jzs66CUjWht2H1tX
	 vXQDMlYoPuasEUwMnjPBi3PgJzx1OgaMMkSw2BU1KSQTvHQfaURRJMyI6qJ5EDFZMV
	 KU6GzegdNlN1w==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id F2FFEF40068;
	Tue, 17 Feb 2026 04:20:30 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 04:20:30 -0500
X-ME-Sender: <xms:3jKUad5AQwpLcRsTwGFcrZgfAB3xGuLPCAYJ38BnfwJUYdTt3r9cQg>
    <xme:3jKUaVvmIPeTUGkoOFQgIrgqytBg8xfoKvS7Eb8rOhu7hZILlXRaQOs5Z5lv7rY_P
    F82jZ2sX3ItCDaUhDx4Cu6v9Ordx-OnaiE2e2mccys4aupyzvVZMJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelfeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:3jKUaQvUYrq89aP4BKjBFrAiE7TfsQ1wuUQgfS0tCurxZTEcwhknXw>
    <xmx:3jKUaRJsKyIrAaOfbfvzMihfbUEBmIVLRowyizn6gunz7MCoHXhtXg>
    <xmx:3jKUaVmK8BRDZRY3hO0bvz8rBNR9b8gN2eNQ4u60cLwDwRedi3YPIQ>
    <xmx:3jKUaaJNsKJwhuC2rKvHpYDkjruqZBrrmcTk_OhyWzHd14r5uJflSw>
    <xmx:3jKUaS5pnh6OAnFuIWQ2oCfUyzeUAKjrWcchWiJ84dmNJwVMdEdyHymL>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CBDA6700065; Tue, 17 Feb 2026 04:20:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Tue, 17 Feb 2026 10:20:10 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
In-Reply-To: 
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6159-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A02DF14A4F0
X-Rspamd-Action: no action


On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
> Hi Ard,
>
> On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>> Hi Dave,
>>
>> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
>> > Kernel panic occurs during a kexec reboot when EFI runtime services
>> > are not enabled in the first kernel. The issue is that the second
>> > kernel cannot find the ACPI RSDP address during boot.
>> >
>> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
>> > However, kernel decompression has moved to the EFI stub for EFI boot.
>> > Therefore, the x86 EFI stub must also be updated to store the
>> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
>> > can find it.
>> >
>> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
>> > reboot will still utilize the legacy decompressor path, so the original
>> > code remains functional though some cleanups can be done later.)
>> >
>> > Signed-off-by: Dave Young <dyoung@redhat.com>
>> > ---
>> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
>> >  1 file changed, 18 insertions(+)
>> >
>>
>> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
>>
>
> The kexec use case is it depends on the pre-kexec kernel saving it
> during boot for noefi case.  I do not have a better idea to do it in
> kexec code for the time being.

How about something like this?

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 7508d0ccc740..24aec7c1153f 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -313,6 +313,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 
        /* Always fill in RSDP: it is either 0 or a valid value */
        params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
+       if (IS_ENABLED(CONFIG_EFI) && !params->acpi_rsdp_addr) {
+               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
+                       params->acpi_rsdp_addr = efi.acpi20;
+               else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
+                       params->acpi_rsdp_addr = efi.acpi;
+       }
 
        /* Default APM info */
        memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));

