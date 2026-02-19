Return-Path: <linux-efi+bounces-6184-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Og7O661lmkxkQIAu9opvQ
	(envelope-from <linux-efi+bounces-6184-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 08:03:10 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 440AB15C91F
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 08:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C2B83043BC8
	for <lists+linux-efi@lfdr.de>; Thu, 19 Feb 2026 07:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F40332EBC;
	Thu, 19 Feb 2026 07:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5FldL+2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bd/PH78O"
X-Original-To: linux-efi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD7E332EAC
	for <linux-efi@vger.kernel.org>; Thu, 19 Feb 2026 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771484561; cv=pass; b=Cy0O97UY/vIaVCg/Ii6AfIEyY0Wlxb2zvDdurnv+Za7VABmyAgzwSOt8XNU6Eg1FrC94oWzsLR+nptvKtKxajfwA2/v7woYEQXfbWftnoy0Id4oy29N/kv1xkzvUhCkwoS8qSZLD7yQ6hGYcw2/kP4HbXvIMCiTX3bqP+S2vAKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771484561; c=relaxed/simple;
	bh=5gvYeJWf0G0NMoIKDmlWrqpvnEgP3VRcBjhtEallFVw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UNmHKfobg1CLPAjrSVPUJuwQ58X9oHYQSKgXb7xCyWVHvb8CHzVUA6VCrB+hpYkpESlkcxu5CuvRu0VVYo/uhoWpJJQ5nCMcxKuq7/CrLfAMbciUZPE17361wv9bKlN8vg4NCxh9RTycG6xwN4z/QwYC/LHAei6QGw+M8PeCGMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5FldL+2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bd/PH78O; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771484559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrfKS8PiqfmgmByO6Y2CU8HPqfpLEZxb1TiV7UA1AMY=;
	b=B5FldL+26ZdV8+45OpnHMMhbmQdrK1a8WBfLtpDlGXSllDUIOIBYbzt7A44nm0DNYPOudn
	0JEZM7U38DAQn9UHBBxBR+m31ZevcYNtSshTPMvmgU4epnaaO1uff0D+9OemWu8u7EKMoA
	xeT8SNz+IoaEm6UfhFUAGMkw0J40fgI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-IMftROUaNkaUrOB7gAbzTw-1; Thu, 19 Feb 2026 02:02:35 -0500
X-MC-Unique: IMftROUaNkaUrOB7gAbzTw-1
X-Mimecast-MFC-AGG-ID: IMftROUaNkaUrOB7gAbzTw_1771484553
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-385bd85a0f4so4219341fa.3
        for <linux-efi@vger.kernel.org>; Wed, 18 Feb 2026 23:02:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771484553; cv=none;
        d=google.com; s=arc-20240605;
        b=Vw0f3geRrhR2QKT0+mkr9CGrJV0gk2cQ6D1R0TfcvNgpeGP6DCEyMOPgUXrHYWKd87
         IqIU1I+bH5YixpOIXm6HJMBRHjsOp/NGpKLf5yYBc77P+cQMnX/+yxxc0wcbBKrj2skt
         XAEXxngwZ2YittJEaZH2wr65j3uAkWi9SfPOcLPfwIXjs2ad1X8t822HUEoUW9WTyN/p
         P+UQiRxA8YIt2gStc/KpUhPkD0+llyaPJhU60SxyicOzdd2RK+v9GmlVxBhPhH6YUTs8
         6lOVmMz092kpHUT3+f+4cZnwgtiraHTFenLUIjker4Fjp9B4NHE+3dzGk2RUWcllfAsk
         eVMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WrfKS8PiqfmgmByO6Y2CU8HPqfpLEZxb1TiV7UA1AMY=;
        fh=G/e/8nSSnyPjsBsyVMWIvFLYC3yGaE+4/NoxrzrupaQ=;
        b=i2Qc0vhwpY9n8liPuCjauWMD7uoJqGOZWkyIxD//fnQOtkA08uuppZYFi3aKbNUCG3
         x37PX/RnL8Tye3vK/LFQC9kUUxWpcVa3h0vFNjgcd/2tY48IHDzuqJ7P7AH8r+U1NplJ
         MSPxeVU6wJVO6X1XGkzphdXLEcbZ6NW9cwQC/eT7LUt+avXhcpk1xo6bF+fe0QM38fKB
         fX8QcOjvpGRAsBrWmyf8Cl/UXnRT25V2k2TAGlq70GmFgwH8JpdDpZ54H+ZIkssmV9Ms
         da7Uawa8yr4qf6V+SBaRWuKsH/EFzUeBbcqQUFGFoFac+HgK6A7l8tHB8HoeigbuZgzc
         OEtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771484553; x=1772089353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WrfKS8PiqfmgmByO6Y2CU8HPqfpLEZxb1TiV7UA1AMY=;
        b=bd/PH78OURA4p3zO71hWrULJE8ZysHl+3fK+PSFpL3gsjtUaKYup6DkrFy8Uqrjo03
         V09bQGbz6bLQi2eI1Kd9+QWctphsV7OKC35Uz58w9jX+GD3VCatBZklPw0Ziu4MjAk7b
         GVz2UModopo+3pvGUfj3U3FtYiFV7l2KHI/v113J3cFQLq3ooCe+ffmIracYvWj8PwBj
         Ow3h+aLAOR3zScvNAs8K/q08k19halbvgAmB9jSRKf7cIY1EkkdRtibQTP4bBqUZR20M
         Xj40LrVojxY97kUC3kz+5RhfnyYtXMgaLHPdDN11+fNVabKM38pEVbWXYI5HixkH6ISW
         /sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771484553; x=1772089353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WrfKS8PiqfmgmByO6Y2CU8HPqfpLEZxb1TiV7UA1AMY=;
        b=RT+7AlKslPpI8UgJt8r7laipKdzVSSKudprBfGExbwey/VIpTlsLiTXLntoTIotJg+
         sBrlG0utynSO9o85+7gsL6B2QRb7ULKkwqxhnhLd1JenAFKvKTlUgNMMtYXSyu4uHx8b
         RB0xLkswZnztyD9nVZ95T0Sw8HwgCFTgD+37CL4BRx7yQQlzMooJgc+3VijpDHKa2XH2
         vEfAf2iXqBy9iY9bijERVjeYj2cVDNM3aEUJhecn5F4z/o6zl8QINCfNJLdLjEZb75QS
         NX0B1dUoDOJKDsHJPZwXdrCwWt4T9RQtYsKwAQKiK7boI+RH5DEqXCykpgisGV4yNmw0
         ESOg==
X-Gm-Message-State: AOJu0YxV2H9nnocKq9FpfXBZts+d4R7Z2heGsJpU+qD8Crhb1xys5kR1
	f7Jt/nGoEGrauE0pXwd+H+dX9oqEkXDaPQUl1iiNm5nPBLczwb5jSOXqsIhZ7wGZ/CKaLMYt6my
	NBy+hCC7991bqVM34vHB9yyNyahO/5jwrSpv/BGN62I0g5kSj++d48igonWBzHhBTealcbs/+lA
	xjGadRj/LdmTRwnjxi4OjByTep9+7ueER2RcfS
X-Gm-Gg: AZuq6aJ6LbskJgQXnjewIJGaNUBF9Xx5qpRvFU8KqRqUvQz6i5TLa/A8Blw5tU79x58
	CCs0QBsyvettk0TiAt+5SEtMC6/MZmoXu21jTcYb2snkEyfmDPio98zkFPfUkCBU2mYd+X2v8lt
	HYG8ao0K9OomjQFGl+AcJsqBO0lKWAqZyyZz2+cDq0GZjSN9gN5ifc5GuIgsYv202RfcMhub/th
	BF3qRwWc4ieCDgS5plpESLRMPae4UoI7Ys+z7o3tErA+mdXzUZjH9Iqg2PU4eWssUQC
X-Received: by 2002:a2e:a58b:0:b0:37b:b849:31c3 with SMTP id 38308e7fff4ca-38846e6e936mr13767591fa.44.1771484553392;
        Wed, 18 Feb 2026 23:02:33 -0800 (PST)
X-Received: by 2002:a2e:a58b:0:b0:37b:b849:31c3 with SMTP id
 38308e7fff4ca-38846e6e936mr13767481fa.44.1771484552924; Wed, 18 Feb 2026
 23:02:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aZQg_tRQmdKNadCg@darkstar.users.ipa.redhat.com>
 <824bf9d5-93d3-4791-a064-3852014a1264@app.fastmail.com> <CALu+AoRdo5E-irxymu7WAV+L=sKLbjnOXtLLe7RHWX-NZtjvNw@mail.gmail.com>
 <61f0c9ad-a435-4856-8ebe-d5a81f72330e@app.fastmail.com> <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
In-Reply-To: <CALu+AoTkGWXAokzXwo6C+6K1-mk3r9YA=WauXAggP628F_=ABQ@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 19 Feb 2026 15:03:05 +0800
X-Gm-Features: AaiRm52CO28LXPWE60CaPB6MX5LkIrQ6MX8PJpryZg4FynCBCqSHZH7nUJrQslg
Message-ID: <CALu+AoRK8OXYb17=0WKkJfS=Q_9ssuwj+Ub+ZFRuS9_kdzo=Eg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6184-lists,linux-efi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dyoung@redhat.com,linux-efi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-efi];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 440AB15C91F
X-Rspamd-Action: no action

> > > The kexec use case is it depends on the pre-kexec kernel saving it
> > > during boot for noefi case.  I do not have a better idea to do it in
> > > kexec code for the time being.
> >
> > How about something like this?
>
> Thanks!  It works for me, however the legacy kexec_load syscall still
> failed with a panic I did not dig into the root cause yet, I supposed
> it will find the rsdp from /sys/firmware/efi/systab file, maybe some
> userspace code bug.

FYI, the changes work with the latest upstream kexec-tools,
In case someone is curious, it fixed the wrong "%lux" with ""0x%" PRIx64"

Thanks
Dave


