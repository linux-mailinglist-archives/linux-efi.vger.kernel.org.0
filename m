Return-Path: <linux-efi+bounces-6160-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLgWM5U8lGmTAwIAu9opvQ
	(envelope-from <linux-efi+bounces-6160-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:01:57 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74514AA23
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 11:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48C37301F4B1
	for <lists+linux-efi@lfdr.de>; Tue, 17 Feb 2026 10:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A87320CB1;
	Tue, 17 Feb 2026 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIpePlxV";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UW/uv7+I"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F337131B131
	for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 10:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771322492; cv=pass; b=ljDOpnt+cI9iD/JCAAMAy7uJn4OST0ERbpdz1JZ0cdBrZtNVvx6ds8k0KyMQDz8pa5XPJja4lFWbtM7ucIMYu8DnL30OHKNmI0Gq+ruUh4WmMk2HUoVevcnuo9FFklHphMv1nhE2IXZetEzGHQ64KFP2Nfg4PlUbJ/tBBp1cOmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771322492; c=relaxed/simple;
	bh=0PGK97bWG7yPCQasYcZlVCW70ykJbCN9ANKDjqr9yXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aY6ydXZcapUlOKRRVucd1+ODhh0JTrd8+MCENlawBczgKtC8kBVCZDtFyP8e9CrS+Nps0UqrSmOv0PV66aKFMtdOhMLE6lMGA6lptiSxbfNp6PmHHyelG2Y1JzHWWO4daofjpf0YWyWSKR2MMDH354PBVdnEFcun0MZtn3Pgd54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WIpePlxV; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UW/uv7+I; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771322490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WkP9sV7zEEh/ycQYc4JlwnuQ3mFYmRf4njLKvnF86jU=;
	b=WIpePlxVTHpNo5C4uk+McKlakJD0awMuONoE+t6VPTohIEpN4OXQlJgNRHQ766Qt6C6IlO
	He4XfftROpH5h/GRmNZ3PhCheJR0GUX0MNKq5gTyRbKFKkD/5nYdGWiqCdv7ZA2QtCEY1z
	6ySkZM/KSnSXG9UIjxRDofy+IQ/oLsU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-gq-KF7lTPxC_Fsyg28HtTw-1; Tue, 17 Feb 2026 05:01:28 -0500
X-MC-Unique: gq-KF7lTPxC_Fsyg28HtTw-1
X-Mimecast-MFC-AGG-ID: gq-KF7lTPxC_Fsyg28HtTw_1771322487
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38712184678so23102381fa.0
        for <linux-efi@vger.kernel.org>; Tue, 17 Feb 2026 02:01:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771322487; cv=none;
        d=google.com; s=arc-20240605;
        b=ddiLx454E8H8M3Y0Q26tXA4tHNUe+BzK3fybq0jB/D5wiFVNq62UXosL1njE8DYMfb
         4XIzm7WwUUjQtqML7kfbbZVdfZU9kS2hg7O2FSPG/bBqVOBn/XgeIfTah2NDlpOJgSLk
         ITMqoRyiAMj2XuR5suAfDFujuYdUgdQKn1VKpLfNaQrcx+OCKmfDyCdizlUvOK/No3l6
         ObxviTgFzu+J2tMQ8j1M9j5ncjzvKTn/+ZvYA9PBe4qGjZFlRET6dGyjm5XDZgUOKZP0
         x8MD623AyhE6om0xSLgGXYXjLm//A908MXAF0LMByoX/+f4GrEaQDbKqqzwp0etZyfPI
         A/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WkP9sV7zEEh/ycQYc4JlwnuQ3mFYmRf4njLKvnF86jU=;
        fh=G/e/8nSSnyPjsBsyVMWIvFLYC3yGaE+4/NoxrzrupaQ=;
        b=bb2Ajrsf7ow4XfN+5utr/5VvCyMouiO4XiIHBOPuGs4v0sJEm0hbIwjHGbsi6dlmR/
         oalvyhirNiSmwKj4+OBuTc52yPKp2Vr1se7qUJWMfkCk/uO3+MnympnBxraOVKz2XYZV
         tNBp128XJ7/d6SBroNkhK6lQMBRpOzYi4Kltw8dO9Cw9URN6LHzOZtjObA7XkRj8yKQh
         EXn52B+pL6gnN3tEqwpl8zVPRmZCCLe5SC19Rt4nf+jibgKW0yHjx5QMw8YEgCHAto5u
         mU2ZpjYtlfOZPc1oPlD+Cq6178ppYWjiGPpzf/eQU8gx25ZazEAbw3SeeBDlpEma9H/C
         5Ggg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771322487; x=1771927287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WkP9sV7zEEh/ycQYc4JlwnuQ3mFYmRf4njLKvnF86jU=;
        b=UW/uv7+IVPGsFkMqd1r/ulzByCQzSo2eTrrv0CkBX3lYbEis40UshHaqibCkBKWjRN
         4Eol+LSab8iXQHiVlF4g6FrVTIPxx+b3ibcRB4/IYC31GtUwl49ES6S7mwoYNPQUPwsm
         yqFxGjG5+8/1P9l344tIQAHu2SNa+WPbCdRUVRKLndGGzSe7n6prJcojcITZUwxCL/nV
         IrKa/DBfpWzrkDXhy72D+WEMPMB4I9L7yQwltckCB20i6rv5bcZK5ECk0zs+BpvFVFGN
         UbnVw0WkZh2SpZYY00kRtYqubsh6bdVM8dq9uoslgvS48gnM+7i7J1xp3LRFVtKhX4X5
         2moA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771322487; x=1771927287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkP9sV7zEEh/ycQYc4JlwnuQ3mFYmRf4njLKvnF86jU=;
        b=HKqJlFIVjJ90RDqYs/uzIk3J/DwDRZHgkxFUP0RZq60z/OKqqaNVbqc8IwTby/SBLb
         23EuP6f20fW5jJUZ39CjWNgBFruf3MAzf5B6pa9vIA78KEP5/SBPR2XYx8015Dc/NQr1
         foFxsku3GtVSDAaLeLcUP+JTjcbmvVMvP74+u55B7ND/vIm5LNZgwi6DdeSsN5hxMoSj
         AgqVO9GDdTB2Q3b5eokE0y+pQlrDHrwTz1ULYzqqjTWV9DRQom0FqvwvcXjqwtnZbWCH
         8F30M0Gmr8r/EM35fQJPN7spvKrvjctGACW1sAlIUK77Ri4tge98KpPlJrFQ9XIFceNY
         fi+A==
X-Gm-Message-State: AOJu0Yz0lEWTJWD1M3+7th54ItV1iO6Bcsv24Fcwt617d7ryvefT5Mnm
	bnErM+KF2Zwx/9CH+UdxJq8F6mMs0YjxZxgFNd74FaqRoe7W5b4BIRUPeA2VAu3glC9DvX9nRb2
	gbmciPNK+0ji5AJIMU2IOLkUTFyjvU9/ObIYwRlaEa0XFHMAxgMrxJ3dtpMtiWvQUjIfNCbdb0t
	ZsCtwOQbbgtdb56Tlp0r/CSZRi994sB2ZcRfuq
X-Gm-Gg: AZuq6aLaqdaVB6skocrGPcYTQP8C64p4IFsQyiARJ4vYUjigujgZKFx1lPttUYlNR2L
	VV2EInKMtJl9IKhknmUxv+39aCtNuV7L9DJO+mphnac1MecA2Nlkbf3qyyaNcwrOIj/NUnbRRXk
	sYUhfe2BWcnJkRBFQ5vCMv17mPbmzh7JCifBBWhB68YasrkMzhELM2Ic8006NoygWxDcF9riG/8
	15i3gMpzCH5cttTKcQwlfUyvm0MA1nSHjDv8BlMKdfdCbpHZGaD0dKLvjR2lp/z5zeh
X-Received: by 2002:a05:651c:1ac8:b0:385:c21f:37e1 with SMTP id 38308e7fff4ca-388105154f8mr30173331fa.15.1771322484903;
        Tue, 17 Feb 2026 02:01:24 -0800 (PST)
X-Received: by 2002:a05:651c:1ac8:b0:385:c21f:37e1 with SMTP id
 38308e7fff4ca-388105154f8mr30173181fa.15.1771322484427; Tue, 17 Feb 2026
 02:01:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com> <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
In-Reply-To: <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Tue, 17 Feb 2026 18:01:55 +0800
X-Gm-Features: AaiRm53GXhlC37NOtJ3S5h3LMzGLEWl_lhdxyUWNnt9ZM53wyjhzIw3ZXFoet1Y
Message-ID: <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6160-lists,linux-efi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[ardb.kernel.org:query timed out,dyoung.redhat.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyoung@redhat.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D74514AA23
X-Rspamd-Action: no action

On Tue, 17 Feb 2026 at 17:20, Ard Biesheuvel <ardb@kernel.org> wrote:
>
>
> On Tue, 17 Feb 2026, at 09:19, Dave Young wrote:
> > Hi Ard,
> >
> > On Tue, 17 Feb 2026 at 16:10, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>
> >> Hi Dave,
> >>
> >> On Tue, 17 Feb 2026, at 09:04, Dave Young wrote:
> >> > Kernel panic occurs during a kexec reboot when EFI runtime services
> >> > are not enabled in the first kernel. The issue is that the second
> >> > kernel cannot find the ACPI RSDP address during boot.
> >> >
> >> > In legacy boot, the acpi_rsdp_addr is set in early x86 boot code.
> >> > However, kernel decompression has moved to the EFI stub for EFI boot.
> >> > Therefore, the x86 EFI stub must also be updated to store the
> >> > acpi_rsdp_addr in the boot parameters to ensure the kexec kernel
> >> > can find it.
> >> >
> >> > (Note: If the pre-kexec kernel was itself a kexec boot, the later kexec
> >> > reboot will still utilize the legacy decompressor path, so the original
> >> > code remains functional though some cleanups can be done later.)
> >> >
> >> > Signed-off-by: Dave Young <dyoung@redhat.com>
> >> > ---
> >> >  drivers/firmware/efi/libstub/x86-stub.c |   18 ++++++++++++++++++
> >> >  1 file changed, 18 insertions(+)
> >> >
> >>
> >> If this issue is kexec-specific, can we move this to where the kexec code prepares the boot_params struct for the next kernel?
> >>
> >
> > The kexec use case is it depends on the pre-kexec kernel saving it
> > during boot for noefi case.  I do not have a better idea to do it in
> > kexec code for the time being.
>
> How about something like this?

Thanks!  It works for me, however the legacy kexec_load syscall still
failed with a panic I did not dig into the root cause yet, I supposed
it will find the rsdp from /sys/firmware/efi/systab file, maybe some
userspace code bug.

Anyway I'm fine with this fix,  would you like to send a formal patch
since you proposed it?  Otherwise I will resend with the changes.

>
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7508d0ccc740..24aec7c1153f 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -313,6 +313,12 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>
>         /* Always fill in RSDP: it is either 0 or a valid value */
>         params->acpi_rsdp_addr = boot_params.acpi_rsdp_addr;
> +       if (IS_ENABLED(CONFIG_EFI) && !params->acpi_rsdp_addr) {
> +               if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
> +                       params->acpi_rsdp_addr = efi.acpi20;
> +               else if (efi.acpi != EFI_INVALID_TABLE_ADDR)
> +                       params->acpi_rsdp_addr = efi.acpi;
> +       }
>
>         /* Default APM info */
>         memset(&params->apm_bios_info, 0, sizeof(params->apm_bios_info));
>


