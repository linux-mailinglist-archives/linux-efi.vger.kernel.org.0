Return-Path: <linux-efi+bounces-6059-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI+yIG0xfWntQgIAu9opvQ
	(envelope-from <linux-efi+bounces-6059-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 30 Jan 2026 23:32:13 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C03BF21E
	for <lists+linux-efi@lfdr.de>; Fri, 30 Jan 2026 23:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B0193007C82
	for <lists+linux-efi@lfdr.de>; Fri, 30 Jan 2026 22:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A86352C2C;
	Fri, 30 Jan 2026 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xSsduIhT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBCD38A2A0
	for <linux-efi@vger.kernel.org>; Fri, 30 Jan 2026 22:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812329; cv=pass; b=BmzoeBz9GUeL7BPAU561zWgJfJVMJV37qWusPecx0D5x7IITZ//VPcaYy4Z3KYBCBkWo8OESzdErV7InVWeIInBT3jzRopmjj9znDV/x8u0czt6xX9WqyKgjQU/TEyEPNkBUHmjWSWnIltp0PKKh9hVdOpran2yjzKyNLjE5mHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812329; c=relaxed/simple;
	bh=1L9Z4WjLTMd/nETiB4o0uKotvQN4Rh7dUtNkmBInouo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5InNCttlg/jhPUBnWvOdbiqXZdad9HRryrzSuOXjW6w3xb5OLNt/IGcigbg9KamsuhsdzmCMJeDPhDbnKkp42sOmzQoRLwQAdaNqhynMpUVs14vAeoeKXJFOgFz0ERJQ1sdyMOtlcJcSOB31B94E2u7jKVRXzIwTb8VVGUr9x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xSsduIhT; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658b7d13f09so4901868a12.2
        for <linux-efi@vger.kernel.org>; Fri, 30 Jan 2026 14:32:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769812326; cv=none;
        d=google.com; s=arc-20240605;
        b=jAVxQMCHFhCqZTdM2Zx602UgliummmuAg7wsh5Y+Uf0ldVk4wvvhXYDQLrwEQAn531
         6VvbFyYN7MhPEz7zVHjVq/8GB993Lz5A7JJ/U13V8C6uIQKfhkROQJBLebAo3CkQVvhc
         YgLTFQo8e07a4yaGxZHY/D1VmvUddIf5m3icIiNlKCId/qbVytNvCZgAksA1pfmgYzb+
         6o2bR8QNfLBUNbM6WWOyO5axL4Wkumjnmy6RG7FsRPR2wk22A0HC0ZtzUsweU8B4kFHK
         I5D7N/aopQK8Ac+7paxKeFSOOLVSBFxysM29o23dCSzm4c+hFB5oIQDYGyzzuv7DLpJ6
         kUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        fh=q4QlIl2+7Eh4mEdVJ6tGgsNDJJT8GhRWrvPjXg7R17A=;
        b=S/8623d3sKjo/CuWMGIAuGqV7AzbhxYObc6D3+o+piV6Cot1LlxNTIN5XHU7Ya836u
         B4EZ55zhh1yYljmRy41Kl8yBN7acEHUmIXUglNGb9aAJBoJzKN/fewrTwV7vBPxo7Hyk
         kRWct8nqrBhFEX64xEV4UikwZXrQ7QcGsRtSZaPr+Z5Zpw6HKio05e+Bhp1/ZdzR6qSt
         pW05crzKvDcQ/7wzmFN+sRGmRt9srC0tj1DZ5yTlY5FFPh14dFDxUjztNZoaCt2aM/Fs
         9neIkB2jN52upePf7RWMOSVgOzqHVt/8tsvKvZSO1UddM/AmMKm0OoHMcMbAC6NiuumI
         4EBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769812326; x=1770417126; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=xSsduIhTCrRwZ3JLNdbKh8tE+MdhFL5H9uFQ+5tllsHBric51bEYgyU7uP/nPJVuVm
         PXBuoZbGBGhd9jC11zRL1GU483f7Fvm6uslzLapeb6QBFVPq0QqUEi22Yh4za+kn63ZO
         VYPzScWvoAqGFSaLLyA8MHrbxgl4Go5rekjKE33pKIWosCL170UwdnhFMbcWW6Jy1nHl
         BTUoIyOiMwtb7w1k7xMz4I30jgy1NoIFY4KeyxuPTUlWRVzku48qag4B+Mw5y3wg9X4J
         7qYXltKRhjuTRa93Kg/i5KMrUJXJP9GaY7mIYlek1UyxtuCoSVeghV/7vYzm2MaotHdL
         Ekpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812326; x=1770417126;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V5nbc6oPm8LRFAHxRjfK4s+TrvKdniacoUK6JWeX1CM=;
        b=jkWkGa3uJxrZ8VUM42AmAPtjn6NwEXqLqt2mkiB2erk0q8RE3/tUwyqr6Q1O9C909I
         WvAWoG49IHGucrpzgKA84t5v0wo9XGSBwmDX/Kko0QihNdGamTKG9oNkDUVK93IQod9i
         ttUd8bOf5HVnbeURcH8UWFbwtq8PTenKW8U51HHqWjVKKNAtvcX/eTMH+3NPduo55laD
         BMPUxXjK7FmNH7U9+1V1GSnNSAtLEVfEucn8nCpKL13a6zn1yJTQILQ+PqwR9ibAcMDG
         RKXzetqBQT45E5jnEyLUYUOf3OK3vEbpyKMjXaeO/E+mNKqpkupvEKtA6y8CbVkkGhcO
         MV9A==
X-Forwarded-Encrypted: i=1; AJvYcCVm3RbVsiuddORSzOFvC2PyYsgQfRR6/y4ka7Xq8IcGme372/rLUm56gldDmrL/kOAFpEtXupivZus=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrwIKycheKTYOKBx4zU6WLKBGFf6cZDPwtEJsulhJwMnkFFYsZ
	vxhgdV4/nDGlQBpdXvEvyoIlmCzIRAyY1SG7XqqRKmshZHOPV7OvNMpxZf+nXHJz7cVzSA29Csx
	4ot8i29gDD5ypJTSjHuKc2D9kApM/qMWqg65joItS
X-Gm-Gg: AZuq6aL+oD5lrThTcyQe4PCV1BdEaAOlIAFYIk4tDr+xrqE++0i9QoxzYeBUwEqPEnq
	9Z1xaf3s0YRUdk3gk8Cim60cEsllGIMH2SoT7YBo/zgtNLtnzAfA+u37zKDqh1LJ/OTEEBuQ+QW
	8T+SXD4Ci1RVyIHVMGEb9frn3/RKTm98fH9QzmqMzoAO6o5t4v+XrQw7E/9/fVcrAkXRGREBtQ3
	t442Fo4JTEHoIXlXsw7dgTS2tZT6nhTGkjH2ASLY8OMj0LtkCcAxBitYMNnAAk28bcl
X-Received: by 2002:a17:907:e0d8:b0:b8e:14cc:9197 with SMTP id
 a640c23a62f3a-b8e14cca990mr91520566b.15.1769812325869; Fri, 30 Jan 2026
 14:32:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118051604.3868588-1-viro@zeniv.linux.org.uk>
 <CAG2KctrjSP+XyBiOB7hGA2DWtdpg3diRHpQLKGsVYxExuTZazA@mail.gmail.com>
 <2026012715-mantra-pope-9431@gregkh> <CAG2Kctoo=xiVdhRZnLaoePuu2cuQXMCdj2q6L-iTnb8K1RMHkw@mail.gmail.com>
 <20260128045954.GS3183987@ZenIV> <CAG2KctqWy-gnB4o6FAv3kv6+P2YwqeWMBu7bmHZ=Acq+4vVZ3g@mail.gmail.com>
 <20260129032335.GT3183987@ZenIV> <20260129225433.GU3183987@ZenIV>
 <CAG2KctoNjktJTQqBb7nGeazXe=ncpwjsc+Lm+JotcpaO3Sf9gw@mail.gmail.com> <20260130070424.GV3183987@ZenIV>
In-Reply-To: <20260130070424.GV3183987@ZenIV>
From: Samuel Wu <wusamuel@google.com>
Date: Fri, 30 Jan 2026 14:31:54 -0800
X-Gm-Features: AZwV_QjYrhpLENkXIfDxcZ9u-zvP7f57lE4mcVebqUxFVKgl6ULvCT7XG0RHQoc
Message-ID: <CAG2Kctoqja9R1bBzdEAV15_yt=sBGkcub6C2nGE6VHMJh13=FQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/54] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org, 
	torvalds@linux-foundation.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, linux-usb@vger.kernel.org, 
	paul@paul-moore.com, casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org, clm@meta.com, 
	android-kernel-team <android-kernel-team@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6059-lists,linux-efi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wusamuel@google.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0C03BF21E
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:02=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> =
wrote:
> OK.  Could you take a clone of mainline repository and in there run
> ; git fetch git://git.kernel.org:/pub/scm/linux/kernel/git/viro/vfs.git f=
or-wsamuel:for-wsamuel
> then
> ; git diff for-wsamuel e5bf5ee26663
> to verify that for-wsamuel is identical to tree you've seen breakage on
> ; git diff for-wsamuel-base 1544775687f0
> to verify that for-wsamuel-base is the tree where the breakage did not re=
produce
> Then bisect from for-wsamuel-base to for-wsamuel.
>
> Basically, that's the offending commit split into steps; let's try to fig=
ure
> out what causes the breakage with better resolution...

Confirming that bisect points to this patch: 09e88dc22ea2 (serialize
ffs_ep0_open() on ffs->mutex)

