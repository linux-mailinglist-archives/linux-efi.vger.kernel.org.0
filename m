Return-Path: <linux-efi+bounces-6162-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eETeHk1DlGkgBwIAu9opvQ
	(envelope-from <linux-efi+bounces-6162-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:30:37 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD35514ADD0
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76BB9304C13C
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 10:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C8C2FF148;
	Tue, 17 Feb 2026 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaCAyBQK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="jhZq0XST"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4DF2FC881
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771324136; cv=pass; b=r7Vqy4mrMCyn1OIG5BNr8+tASStnLuWC4iqGYdyLtn+mFCazjN2KmJf5z7EomhXc7jE+CEAJcOQ57D48KwQ/Wh6w5IVaQMwDHOB7kNGOzFO1cUi5XDS8NYDhcKPQ7gNXmCT+INQqiqjkNmNlsJO3zVb2goHUBhAhWRKHH1qvrxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771324136; c=relaxed/simple;
	bh=0PsCsoidi5JzsoBY6QJaznH7n5nF0RCA8qTPF3U8pRo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ABP6krgzUbdcA2nujgpVgJjSECo40Bzp0nInY5IyupyhM/gl5DpeHH1XtOj47dGZL8orRT0v8DUETH4IgMu65Wplo1OjqMiFR85ppdXE9ySvimIHgged3nSxfw+gGkyMgC6J33zt9aP3Ka7D9fM+GHktTpMZu7NosARNPGQpMmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LaCAyBQK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jhZq0XST; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771324134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ncftt7M/7L3tvlHxJyD2ceg016L/Z6MXyuNCrzU3inY=;
	b=LaCAyBQKRYxuFHgKTkKKTURzCcqFpHyz1BX9ufSDkgcgvscqwYx5t2KaTDYQbvZeyWpqmd
	K8YmbRrUU5dOQ3xmm9uk1j0/gP+je3Q/30ZR7SARruJpukTFXEzxYLG4VR/GDPKaoqeBJr
	HVv4Ie0rRAQ7hdkB4MROxjyzpVFqJ9w=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-X1lFIabaPXqgj5wpUbnQfA-1; Tue, 17 Feb 2026 05:28:53 -0500
X-MC-Unique: X1lFIabaPXqgj5wpUbnQfA-1
X-Mimecast-MFC-AGG-ID: X1lFIabaPXqgj5wpUbnQfA_1771324132
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38708f5cbcbso11644231fa.0
        for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 02:28:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771324131; cv=none;
        d=google.com; s=arc-20240605;
        b=NCkpMg6oMUkO740j60ysB3eW1A3S35ZpGnXemFhiBELQrjG86jQZDw2U4iWlAOF0d0
         N9DIWWOJ+4j/0nwBf8G6Vs97Ca1StDsPLzdHlwMihBWGTppj4z7dN5Tx4eWUW40cg45E
         vFMAj2211qv6TO4EdyCtNDvUNWbvmGA0vJEowuzTdQ/53xEYdxoXugIIX74oRTQTk5uc
         8oO7Y0ULSYGpAEwREXqaixAHGTwZIun2FFupMwgGAoHFdpZXG5Hv3Ft18gZOr2ATOijm
         wvmhy3DPxrrA2EhxTcgUQoXXqBXL+L/8MAbEnEtg9B6T4u5hsgorC7b/3ASy+7ziEI42
         p1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ncftt7M/7L3tvlHxJyD2ceg016L/Z6MXyuNCrzU3inY=;
        fh=G/e/8nSSnyPjsBsyVMWIvFLYC3yGaE+4/NoxrzrupaQ=;
        b=OVPwOHnSHwZS5MxUbVv5oJnTw8+MCVUqRJk6oXPohl7BMil88lRQeGhu2rkOoMP0nG
         Ovs5bIuVF+RpMiTvhnqDSv/sDFzJ8qxy+sCeK5foVBMnuzumnfwimfOC1zsUQutH7wni
         Pqk4DthSYRmLyTCHlYXC+ZeXuNnfOx9k0sf9kVnAaM8a9nfWsiVy+Qi5m/gXAie5WOdF
         sDCbyIhLk7tBNkgL5KPg3xcv1j36hmc1vaU1OU3+i36m7n9OVoKEDkeEUI3UoHOByOmG
         FvC4vE3REZNK8Xf0SN49zLgZgYM9HZKhlUKgkJ1lry2RPtOgirHPiKOFdop90dJ3qGUP
         +6SA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771324131; x=1771928931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ncftt7M/7L3tvlHxJyD2ceg016L/Z6MXyuNCrzU3inY=;
        b=jhZq0XSTx29R/v2UZAbqovEfKlRzKsnKMTlzfxM/CHMQDvwlzBJugxakO+rPJTEGZS
         nyn+w8MO9gXdbXeouTZv1BbM5KORq/qqTDf1AeMqfOUNioydQwb4l/KQD+Q0WpRioQhm
         MjCm/KIh3aKc3I0l+d25ukdmA0l6oPV7eEe9H2Wqw7LUrJB+ZxmMr0v4vZWDkXXCrSiK
         XqQ47nOxKc/U8a8O0hJ+8cjxlcLJOzdQc+fo7RCrn5srjentfU7EcsShHQq0xf3QEk4k
         W/CLi6RC/8LP9O94fjFKWwRdmWJD/jhLMgXaNvXHz2XQr2KPCVZ0ljEt2T3V8EPr4D7d
         XBNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771324131; x=1771928931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ncftt7M/7L3tvlHxJyD2ceg016L/Z6MXyuNCrzU3inY=;
        b=U2rvLWTFz/Z9Vz1cb8KeFCxDlWT8boLllwfMqJbJBWvGeegYup5OVBwDN8FldleH9k
         TZ+bQ1MrPxTRt58/MwrEFGL1+55oycuvHs9nisJQnmPHjQ72E/SuZwD95ygGiPS6xbUM
         21oI5+qR58breK56RZf2hnqrkwvXiWy/LQHBUODVS0rysysQ4WOAoYAyGkHEGOovnTst
         B4Klcut/rK7JCMXKE5bksP45fkdlBmkaRIV2XCmEJdHsc4qC+kb7pqhWYFDGXb4tU6O4
         DiO/ixl5zowdILiCQlSUtWgrZdoBFpSogiLY+0PCRR/LE5e2pIsLe7qBWcpgTjZ7d1Lq
         /j4w==
X-Gm-Message-State: AOJu0YzB7x+/7WB4jBR+twJIdpYxIRVIYElfwN32Wy7d34rpDk+q6VDW
	8Al2XVXwTZi4UmWnkqCVL18jTfdAhVEmJAYEmPyurTjz+KsQ4NmC9f1P4YHAXnYaStttdvaRS3q
	++g4CvS7FuKcrhz84ynAM513eMDKxENl9aUk80UQswWCl0Cv0Xm1VENJNLdT2bXlKuLjdhA8tUW
	0wTpDBrxpRWoRnUOfQh1puZJg3eJGCzHreLX9K
X-Gm-Gg: AZuq6aKf6dEmzNMNdc8oOQqDETxFnoCYsdVBeXiiyfPiEe+MH5XCfa0hlFDkYd3XRel
	+NTpGFwZ0stQgOmAk3Kg4d9hTffIO4qvbCFlWa7ra1SnzQ+sNqv/cXGprijGnJY/aZvdmdy3aFX
	WoOPTyTXoHJP0baxOMYNw/ztXFo/KnuxLuNV6piB/eixbiOk86sahIztKJt/yacKgD211C8EG/7
	j467QyMWgWzRcfta5oWgTbeazC75br7lb47WUgFGimHgps8GcEIerscozznXKkJQKcL
X-Received: by 2002:a05:651c:1545:b0:387:90a:e4a0 with SMTP id 38308e7fff4ca-3881b9509eemr28158571fa.29.1771324131498;
        Tue, 17 Feb 2026 02:28:51 -0800 (PST)
X-Received: by 2002:a05:651c:1545:b0:387:90a:e4a0 with SMTP id
 38308e7fff4ca-3881b9509eemr28158421fa.29.1771324131045; Tue, 17 Feb 2026
 02:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com> <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com> <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
 <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com>
In-Reply-To: <665dc599-8488-4761-b3c3-07b994cb82b8@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 17 Feb 2026 18:29:22 +0800
X-Gm-Features: AaiRm50T0aCHGoGZvHbV6ezL2DNwFGmrLSWM7LRCADXyTzZpVgFtpw54zvEwKqY
Message-ID: <CALu+AoQMdng7QfKJjY1wugLu79AWbg0=x9SkvvT6TdwXjviM3A@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-6162-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Queue-Id: CD35514ADD0
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 at 18:27, Ard Biesheuvel <ardb@kernel.org> wrote:
>
>
>
> On Tue, 17 Feb 2026, at 11:01, Dave Young wrote:
> > On Tue, 17 Feb 2026 at 17:20, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >>
> >> On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
> >> > Hi Ard,
> >> >
> >> > On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> >> >>
> >> >> Hi Dave,
> >> >>
> >> >> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
> >> >> > Kernel panic occurs during a kexec reboot when EFI runtime services
> >> >> > are not enabled in the first kernel. The issue is that the second
> >> >> > kernel cannot find the ACPI RSDP address during boot.
> >> >> >
> >> >> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
> >> >> > However, kernel decompression has moved to the EFI stub for EFI boot.
> >> >> > Therefore, the x86 EFI stub must also be updated to store the
> >> >> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
> >> >> > can find it.
> >> >> >
> >> >> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
> >> >> > reboot will still utilize the legacy decompressor path, so the original
> >> >> > code remains functional though some cleanups can be done later.)
> >> >> >
> >> >> > Signed-off-by: Dave Young <dyoung@redhat.com>
> >> >> > ---
> >> >> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
> >> >> >  1 file changed, 18 insertions(+)
> >> >> >
> >> >>
> >> >> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
> >> >>
> >> >
> >> > The kexec use case is it depends on the pre-kexec kernel saving it
> >> > during boot for noefi case.  I do not have a better idea to do it in
> >> > kexec code for the time being.
> >>
> >> How about something like this?
> >
> > Thanks!  It works for me, however the legacy kexec_load syscall still
> > failed with a panic I did not dig into the root cause yet, I supposed
> > it will find the rsdp from /sys/firmware/efi/systab file, maybe some
> > userspace code bug.
> >
> > Anyway I'm fine with this fix,  would you like to send a formal patch
> > since you proposed it?  Otherwise I will resend with the changes.
> >
>
> Excellent. I'll queue it with a link to this thread.
>

Thanks a lot!

Dave


