Return-Path: <linux-efi+bounces-6173-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHUlEzCwlGkPGgIAu9opvQ
	(envelope-from <linux-efi+bounces-6173-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 19:15:12 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F1B14EF8E
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 19:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50E40301326A
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582229898B;
	Tue, 17 Feb 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncWZszqU"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249C29B8E8
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352110; cv=none; b=upegR4n3+KhBwQFFn0feSjR6F1tjD3gx/kkTvX3P/G47a6F7QN0SdWCTegeHgJRm/m0EEmUMYlDnbgz+VLdBNjwsaR61t5IXl7QWVkwupFiezktEvgTS8Cwtm76giSVhZ5IpW8lAFhydQqJpEWaJ2vHFNUs+eax/g0l2GNX18f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352110; c=relaxed/simple;
	bh=BLXPqjtq+IcP0wOW8zJwe5S6I6ouY4pZ9WPNbvh+gvU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JrHDkW/YUfEYkbgYswd/7fR0ZrIOzO/wtPWChkqAKBGwfZsbZOi43RqZ/l+SRyTVwaSrIHme2Hn7lLT/BXD2eKcQfnG4xttt1SbTqEJ47BZm0jzi7TeWhCV2xNvE9TBFoWKhtopeghKUrJQAtV16Z5ShWa0eh+wnVnqjWKuT6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncWZszqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E01CC19421
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771352109;
	bh=BLXPqjtq+IcP0wOW8zJwe5S6I6ouY4pZ9WPNbvh+gvU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ncWZszqUcCkso6eRJYjQF4ykYjd2dea6lzevm+OKxN/OqDdZA5XE83oajZf32yKla
	 3XmIb1zmHUy/HfBNKLxaJZJWKK/cCbtvEpV7MBKMaS1BdIhe6ATBnp09IrVI6BhJZ+
	 +KCCdSyGZRESVQJLrkF8trL7MW89/fPZTvfLI3lN32Z4wys+icRuL4zcxyq9FmMq2o
	 EHKvljejqccnUXKOTe5aYwWzK8v64Iu3kuqMctxAb6LkIRE6t2oZp3dFH/Q08WlWsB
	 DPBPONeSEI5HXzxpf9YHRFEW7ccVYItvGWInw0fEPU5FPkivyyrrsWFeAdPuCdXJnp
	 RcY0a2rWV2xVA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 98AC3F4006E;
	Tue, 17 Feb 2026 13:15:08 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Tue, 17 Feb 2026 13:15:08 -0500
X-ME-Sender: <xms:LLCUaWO0rWTliOLGuI9AMINm3T5W3Dv4sOqbH0wB9M5inx2OQ8cm4A>
    <xme:LLCUafyT2e7ibOvwXbOGRYv8COaM01fgTVvDrYVQHmBjtm8iLEnCR6-19LrbdLVF8
    ToY9IuOZiF4kBWZDGE658AffueZSSTYJQE0m5JtFlffQt0BGutdOsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddtgeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:LLCUaejlUfQxTF9zgHLVwIgZa1YuhRj8LZCgfofr-iOhHyo2rvthSw>
    <xmx:LLCUaSuVvrSv5TMGfY3SJyzEvahKwYyx2I8-2wKDD2F7TeOFhpoQjA>
    <xmx:LLCUaf5_kUWv32vvj-7c_8EVKoVdkwrYluaW7_RdE7HXkBgAOLkkHg>
    <xmx:LLCUaeMiB34u-Xo0fCnfI_nUnPxpVhJYYqIDX9D-HQ5HXBB1_rkqBQ>
    <xmx:LLCUadubG3xD5kKpPRlH0z0HDYGGKBFXJubOapg-bntLNgS7RDg15_8i>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 71014700069; Tue, 17 Feb 2026 13:15:08 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AR4vd3DIDa3F
Date: Tue, 17 Feb 2026 19:14:48 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Dave Young" <dyoung@redhat.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, x86@kernel.org
Message-Id: <eba774b8-1127-4c77-99fc-943b6de8af54@app.fastmail.com>
In-Reply-To: 
 <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com>
 <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
 <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
 <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com>
 <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
Subject: Re: [PATCH] efi/x86-stub: store acpi_rsdp_addr in bootparams
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-6173-lists,linux-efi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,app.fastmail.com:mid];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E1F1B14EF8E
X-Rspamd-Action: no action

On Tue, 17 Feb 2026, at 11:29, Dave Young wrote:
> On Tue, 17 Feb 2026 at 18:27, Ard Biesheuvel <ardb@kernel.org> wrote:
>>
>>
>>
>> On Tue, 17 Feb 2026, at 11:01, Dave Young wrote:
>> > On Tue, 17 Feb 2026 at 17:20, Ard Biesheuvel <ardb@kernel.org> wrote:
>> >>
>> >>
>> >> On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
>> >> > Hi Ard,
>> >> >
>> >> > On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
>> >> >>
>> >> >> Hi Dave,
>> >> >>
>> >> >> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
>> >> >> > Kernel panic occurs during a kexec reboot when EFI runtime services
>> >> >> > are not enabled in the first kernel. The issue is that the second
>> >> >> > kernel cannot find the ACPI RSDP address during boot.
>> >> >> >
>> >> >> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
>> >> >> > However, kernel decompression has moved to the EFI stub for EFI boot.
>> >> >> > Therefore, the x86 EFI stub must also be updated to store the
>> >> >> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
>> >> >> > can find it.
>> >> >> >
>> >> >> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
>> >> >> > reboot will still utilize the legacy decompressor path, so the original
>> >> >> > code remains functional though some cleanups can be done later.)
>> >> >> >
>> >> >> > Signed-off-by: Dave Young <dyoung@redhat.com>
>> >> >> > ---
>> >> >> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
>> >> >> >  1 file changed, 18 insertions(+)
>> >> >> >
>> >> >>
>> >> >> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
>> >> >>
>> >> >
>> >> > The kexec use case is it depends on the pre-kexec kernel saving it
>> >> > during boot for noefi case.  I do not have a better idea to do it in
>> >> > kexec code for the time being.
>> >>
>> >> How about something like this?
>> >
>> > Thanks!  It works for me, however the legacy kexec_load syscall still
>> > failed with a panic I did not dig into the root cause yet, I supposed
>> > it will find the rsdp from /sys/firmware/efi/systab file, maybe some
>> > userspace code bug.
>> >
>> > Anyway I'm fine with this fix,  would you like to send a formal patch
>> > since you proposed it?  Otherwise I will resend with the changes.
>> >
>>
>> Excellent. I'll queue it with a link to this thread.
>>
>
> Thanks a lot!
>

Actually, looking at that code more closely, I kind of wonder why the kexec code tests for EFI_RUNTIME_SERVICES to begin with. Perhaps it might be sufficient to do this:

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index c3244ac680d1..bec91ee7e668 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -192,7 +192,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
        struct efi_info *current_ei = &boot_params.efi_info;
        struct efi_info *ei = &params->efi_info;
 
-       if (!efi_enabled(EFI_RUNTIME_SERVICES))
+       if (!efi_enabled(EFI_MEMMAP))
                return 0;
 
        if (!current_ei->efi_memmap_size)

That way, if the first kernel was booted via EFI but without runtime services enabled, the kexec'ed kernel will simply inherit the ACPI and EFI tables.


