Return-Path: <linux-efi+bounces-6157-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4O8uLpAilGmqAAIAu9opvQ
	(envelope-from <linux-efi+bounces-6157-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 09:10:56 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCECF149BAE
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 09:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 48A323002B6A
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FB2D59FA;
	Tue, 17 Feb 2026 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEFLPw2w"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186D223DD6
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315851; cv=none; b=tLnLEGcGntzsF/NR9yueyQFblCXW7y7m7I2s2bu6evgAY51/gUUMtdOijiz9G1PgXAgVCynklVX4JQYmwAbVLRFwb8H2aUsEN5SGaFMGCu/aUHeCC7VU9j6baUb4gkbejrMd0PSSSCETijdHUjjICLt3Efjg6k53O8wle3drvg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315851; c=relaxed/simple;
	bh=c9RrN16ENka2bmhup2I3IYc94x2FdV4nR1nj/uZkQi4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HCWyaOJfeIGlRrzDpQowNwzc9bz1iDrEay1pe1cMqvsmtVSFlFfow3lm/s3tJzpJbH1qXRFwRYlENHACaWXFf1ZE/QyUkWLqAnh5rGa4Cvjr4rQ1oZNXzTFIznrgTwynZ6Y3/LYwsR8rP8MBB9+IuQRQrcHJh1Q/LbEVprf1o2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEFLPw2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBEDC19424;
	Tue, 17 Feb 2026 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771315851;
	bh=c9RrN16ENka2bmhup2I3IYc94x2FdV4nR1nj/uZkQi4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=VEFLPw2wCCG2u/cUm10oLr8SG9B6/+Tn2/aQlIwm6eldGulzFRZxKpHWlXQUHLdJ0
	 oummYyuiNGn+WKw34GE4QdHgoTzmIkacSlOKtZhHzVRXxk4hWPWUlTwBRAwjaHpSVP
	 Oabn+to9epPmOWSJWPACggTbzY559DUU+p2W4vA1cMuVq7FtfKoYp5Gjl6L+Z0KzKA
	 S98HfNuTh2GrKuZOSkil5HCkSUNbCMUfoSSdsjhDhps0Ybno2ZTlmBTSfTW+XBRZAF
	 w/VbVs7yfuvvMnUnllNRa6CGN+Oi8uOJrrRfHhiyoK95UrX7243ZEBGkx6fxXv0o6m
	 8eSsDW6pY8AjQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 05431F4006A;
	Tue, 17 Feb 2026 03:10:50 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 03:10:50 -0500
X-ME-Sender: <xms:iSKUaQ9Mrqjj3acW4ReM0wa4Q3e2M2uWZRpUcnKibmdjQTFGOLA6tA>
    <xme:iSKUaTiw7mWIdwD_ECugaHflxEgtseq0v1yRorqS53Q9hrbmLDURXTigpnVNavxAx
    PtlVLTp0oXbzvXSAiryM9_7DWAf9eMBndQku1Xne7u41XB4jR6SNJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelvdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:iSKUaTS2KTeFCHBUet9a_R0R8eKXnHAJLrWUSSB6t5WVy0wsf27X5A>
    <xmx:iSKUaYeN1v2QoHx3POR73qm31UWXWBOnelm5-t46sIlwSvuo6essxA>
    <xmx:iSKUaSrnuKrBXGc-vj7S03OmoWRZ_oaHRR0LwDEMri2QDDg45C2YBw>
    <xmx:iSKUaZ-YDzvvqy5hK8vkbC0VC5U7D1AG378EeYg1hTtnlm2rGw_CwA>
    <xmx:iSKUaeekzCM-VDSmM7l1m7fCceMfaOboqTqwXUE47HQOCgKc56YYrIKI>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D4C80700065; Tue, 17 Feb 2026 03:10:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Tue, 17 Feb 2026 09:10:28 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
In-Reply-To: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6157-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DCECF149BAE
X-Rspamd-Action: no action

Hi Dave,

On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
> Kernel panic occurs during a kexec reboot when EFI runtime services
> are not enabled in the first kernel. The issue is that the second
> kernel cannot find the ACPI RSDP address during boot.
>
> In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
> However, kernel decompression has moved to the EFI stub for EFI boot.
> Therefore, the x86 EFI stub must also be updated to store the
> acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
> can find it.
>
> (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
> reboot will still utilize the legacy decompressor path, so the original
> code remains functional though some cleanups can be done later.)
>
> Signed-off-by: Dave Young <dyoung@redhat.com>
> ---
>  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>

If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?


