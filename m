Return-Path: <linux-efi+bounces-5466-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C6C4D173
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 11:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B46163A99EE
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0274234AB0B;
	Tue, 11 Nov 2025 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Cxh7bLzT"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87133C539
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856573; cv=none; b=g10gfdjsLH43ET5hIIjHvXRS4OZ2NMeH6kyjRb5TJ+42xGrthi8uhtvJ+l5MedUCspDWqEe7Yz4/rXUY7tnpT0sT2+CSj66kZgdj3stivaC9XY5cIp20cOM3GMzDin/C1AMQ+y9CPye0133l7hEozPQmepg+lURFG0EmmCDuWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856573; c=relaxed/simple;
	bh=JrxCJS6doR540ni5O4K+fTfT2J1vhfEKtnYrNkU/J6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNyZDrpyzzeW0TnusJ6tVkd5oIMNjE/qIaK3qKrnDobn1xv0R/BuQPLDueeJ+FK32PdTnXXCzH2vHcXv1l+QJk/noldhtr8X2ZpLAhX0g0KGiH5QTXr3jyw+hBknJb3V1bjdCDS+l7ntc0F6BSFs3DhMQQchwqx1kmia/N4FpxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Cxh7bLzT; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4edb7c8232aso28519811cf.3
        for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 02:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762856571; x=1763461371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=Cxh7bLzTrr9BQePvVGjJ40vDC0NZ2fTThVB7BYFO3Iak6qyEFFlUvplymWg0joF7Q3
         HVvSugfkZBwk1iaxvYjWFo+NLRPZYh1e5zW3LFB3CpoBIX+SjOYunRJ+TM2+q8sIqGZU
         epcQ5oRizTN8F+VsWK6pLYxh6lReG0wjdPWAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762856571; x=1763461371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gr4TOuugTT1EseGcVB5iZB82tbqvLcivaLR74+txrKo=;
        b=wtnGyvX4FjFz/Wyup3+2ew64AuN8qo/Xda382kXB+ZBTLhVGR2NQsY+QzzsSt9AmBU
         m0V3BZi2eQA1H403k3c64oAl0iURG4vCbFdxW+sKElnMVynKDhfpot9ENLbIYZsghZw5
         Hn24Mb8xn4qcJfpd5kbNPB9OWkTb5rLWjq/8+s0tmVfAeZP9dJqYND7UKlnEruGCOTAs
         HZaaxk5s8h4PVbdDOSxphTK+ThGdJG/31mk4JbXAvL52gf2OdI/Kt5O1y09oY6a/iYhd
         xzYrJS6wxmFgra3CKopnRFM/WeTTmqb2sltCEJIx/iNjPgvKX3tNhpjbOy/qR+ttK8Ma
         nu9A==
X-Forwarded-Encrypted: i=1; AJvYcCXPTk9nKsY8RSmb17SLD9dtNSBaoYQEKoRcPBUKFi9B62s9vPKybs/0WoSe4YBggrYmfWwp5BTrgmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5I/RX+9fpmkL/SBVkSjC2vkL1VCUs09JsWZ0S/XxjjwFU58ec
	O6juQz13m3nHfes2oQsdM6AJye+8gxmz3ZbQEAJ49fVuwQLG4wGTixCdI8fWSHhZ7c2Hvzi4AVG
	y7pSXt6v680TRb+yp1+FKtU3hcHzuXua4cyWsvKdbDg==
X-Gm-Gg: ASbGncvl1c9Ch9XIF8m+T10m4cy9MzZOtkqWWecYz00nqWr07jPCZU3aOB1jmlrFQQi
	Rf4fsLWOgP+G9IutTxUPWzk55u9HU7XyHWbXRybhVwohpVy6FaV7ZOk2lCOow61oFaisZpOCg+7
	m4Hfq/63tVLSzxp21gEnyFD8B7NyUvDIVuwYn3l59dwEGt/X1AF6GSdfKvpK1sHnlah+t9+nEIy
	wO5hpKewElGoRCndbXetW96CRKycZuUOxGdWlPyg2s4O2EIr6aMmXk6+cU=
X-Google-Smtp-Source: AGHT+IElRIVhqCvDTFpSgFEYkQvi9Gos4SnKPGf8Juir9zGtxxq03gYdBJSCGUUe4Ii0djCwuMFVWPO3CN8YKO0f0p8=
X-Received: by 2002:ac8:57d3:0:b0:4ec:f073:4239 with SMTP id
 d75a77b69052e-4eda4e7cbb2mr148255861cf.6.1762856570888; Tue, 11 Nov 2025
 02:22:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-2-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:22:38 +0100
X-Gm-Features: AWmQ_bn6E4e4WTTnqqQ9ptsMdEgyTHjWIJOU4-smQyjZiT3MKecFKgj620d_-Vc
Message-ID: <CAJfpeguqvHUDVzR7N=To8keErrF8Bn9kuojoFtM_58sLY_XXDw@mail.gmail.com>
Subject: Re: [PATCH v3 01/50] fuse_ctl_add_conn(): fix nlink breakage in case
 of early failure
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org, 
	brauner@kernel.org, jack@suse.cz, raven@themaw.net, neil@brown.name, 
	a.hindborg@kernel.org, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org, 
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, paul@paul-moore.com, 
	casey@schaufler-ca.com, linuxppc-dev@lists.ozlabs.org, 
	john.johansen@canonical.com, selinux@vger.kernel.org, 
	borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Nov 2025 at 07:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> fuse_ctl_remove_conn() used to decrement the link count of root
> manually; that got subsumed by simple_recursive_removal(), but
> in case when subdirectory creation has failed the latter won't
> get called.
>
> Just move the modification of parent's link count into
> fuse_ctl_add_dentry() to keep the things simple.  Allows to
> get rid of the nlink argument as well...
>
> Fixes: fcaac5b42768 "fuse_ctl: use simple_recursive_removal()"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

