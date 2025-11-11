Return-Path: <linux-efi+bounces-5468-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D09C4D14F
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 11:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 80FC54FC5C1
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AC034C81F;
	Tue, 11 Nov 2025 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q4HHA45X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E0934CFD9
	for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 10:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762857006; cv=none; b=GqG79YOwnsskmjglWWbObos3ZHoTcMZa+cibuHFiy84CjgCpAv1l5pJnUNdsfmbabcd5WeJv1EP5oLtcxgTVjoioLj4H2oIIBlu2A6sqv4ZVDputGo1fzLRFmbTvxRRYoMkKpnha9Gt3t/tiS6lhp1HQpMz/sm4PPw+nl2g7RzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762857006; c=relaxed/simple;
	bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rpcggl86yhfzmdRy2i++wUvgDOEJ6CC3BkwpclEJD4xiqVLY+TYZdPRZho+KRbi6FF6Bsxzyq+y3Qx4H+lTS0hNd3OJ8cTHB1RbNT9f7hZlTm0TPfKs4CJX7KGwvJvVQDvRFRBAPpo0Kifz2Dryt2CESF1bJPHGoequYtgv2RfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=q4HHA45X; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4e4d9fc4316so40133741cf.2
        for <linux-efi@vger.kernel.org>; Tue, 11 Nov 2025 02:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1762857004; x=1763461804; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=q4HHA45Xx0xTDskll4DjSU6SWhWolRSlpTtA8cDnYPTI/9mbRIiB52rjVByj7Xz8ay
         nFP0//QDDttEQdXDUPTQYuhtZxg4E9Z6etcMAQhjvLkWtzN7d8du6hlQT4fTRYhV57g2
         fSGQ47hY+Biwn3/0+lGUjV8ol/iJevVJFrQy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762857004; x=1763461804;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErpvLu+msmOQH+DLoUzEraHYQEPe7HwAu5dxR8qbtAo=;
        b=J3ho/PDq/9GkWAdXGrIvrMadQJ2J4rbrCnqF5xMlOcOomelYAQeg0FdiflrczrhLsF
         78V8rY80AZg1oj1ghFU1SYx1Me6d3620DcIuW4gaL7Vs4VHubhBl2oZsf+ifoleKOeOc
         xhyEV+O721DYqmQfoTGOc3oLNbC3fv52DfnEBx/nn2rOCiuNoOZVCBnlu+mJJf1BJ7qh
         jNMr711imlUjEAi4wE4F+pwF/EmJod6u+qctHV73DT6UyXDi3ZC1uXRuBe5DrlZhsNJx
         BqTiBpIQmg76ncx6PwgZvvZs1qWG11lPCfmrD+dljkwjSkxM0LnfZCEHPLnm44LVxOLz
         znZw==
X-Forwarded-Encrypted: i=1; AJvYcCWYO8WQtCS2O2/XcPJZvuLtyqd4SOeC9ViqrF9p/X5UwgARVuX9K7B0pwZBguXmLgi5u5nwfI/EiW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YztUdLdHpCjudAo3vvDXDy+i+h+VodsCcXDi9LrJv4DfTo5E3pp
	OPwlfsItop6GNzgJgrSMTv8IpvHIZu9YDcuaIH2PHLlwhXTYIR9pkYhmLOWCg60lL5jteBLi8vJ
	SZoH5NrNTJCCDQHrJf19iH3JeSL7tk0eTY5+vXKbvfg==
X-Gm-Gg: ASbGnctLVdoIjbmcqsL39NiKyBCNBmlNLU929uuG2wjYz/FstEAVTOkrmHiJV7qLTHX
	qZ2bBWJ8jCTvMvQ+A6UE6Gh+E+bnWGqj7KT8FlStTgLgxVnT59ySOJId2iMBHNa3wOH4iGeRRQu
	DjY+wFhxj7PxHVszfVfOakG8ka8+O5qwZC1pjzkEWMsoJyLQrrU8oJonWO1SOAwDnEH3P9IhZZY
	9SiyQo0C6rlVoT43rqbx9vKdlStbvF9DaCXZ4kDBGAixFJPUVpQOXZolDKAYVpUGpPXrQ==
X-Google-Smtp-Source: AGHT+IG1vPc79jE1NxMTWUcAkMOFXJ1dO7xwNLHncVzXeQGMi6M4ZcaWG7wZ9Wn4xgn8RqaQcm4UKxcrnMz8XFw/71I=
X-Received: by 2002:ac8:7d8b:0:b0:4ed:b378:145d with SMTP id
 d75a77b69052e-4edb3781c5fmr87056701cf.45.1762857003684; Tue, 11 Nov 2025
 02:30:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111065520.2847791-1-viro@zeniv.linux.org.uk> <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
In-Reply-To: <20251111065520.2847791-4-viro@zeniv.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Nov 2025 11:29:52 +0100
X-Gm-Features: AWmQ_bnbS5BGnOdlDcNli2J3_mWe2QdNv2AalQvWZZg8jjhCbQzLKZqYiVdFPQQ
Message-ID: <CAJfpegv5eZK=70GEdbofg8u-CKS7gL6Ur5PD86Ay4h3Z8D986A@mail.gmail.com>
Subject: Re: [PATCH v3 03/50] new helper: simple_remove_by_name()
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
> simple_recursive_removal(), but instead of victim dentry it takes
> parent + name.
>
> Used to be open-coded in fs/fuse/control.c, but there's no need to expose
> the guts of that thing there and there are other potential users, so
> let's lift it into libfs...
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

