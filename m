Return-Path: <linux-efi+bounces-5189-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 527D5C12F82
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 06:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 000563531AB
	for <lists+linux-efi@lfdr.de>; Tue, 28 Oct 2025 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3792C237F;
	Tue, 28 Oct 2025 05:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bBgshXTU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FE32980C2
	for <linux-efi@vger.kernel.org>; Tue, 28 Oct 2025 05:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629646; cv=none; b=HnXNWL7EIjXEJDtz0IJeTdZlmKiV085VIU8ljaESvnB5oLLMiydweDLJcC3GhC5sUYYsVnVZycn92L0qjap8pP7RO10Ct1ETH4YJELj53VLSeVRGizz2MIDnu/lb305ZJ4mOVkvLjv9IHQYDHIv0CNknIXYZxVvo79yx7MKFb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629646; c=relaxed/simple;
	bh=UX3h0Pes41IJIATGA34ZfcGcoxGHwBRZyrCwKR+AqI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktPS+6ZMhya1JJKE0qoCk0gQpGEw5ph2sL2JVX5qKpfE2tzDHwsOWOJE6t6eZg9M3w6xFEnejNtlWwBbhg9V27Y5Q4O7csJzVNUHkO1PzSuZ7FYB45uOAruaIzLphFvd6yB9SauBr9npojBoer4VeQBftOarJSF/VaaVczzxLpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bBgshXTU; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso2397216a12.0
        for <linux-efi@vger.kernel.org>; Mon, 27 Oct 2025 22:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761629643; x=1762234443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=bBgshXTUSZSa8iGJGyo4g0iefNe4uN4gOLC28dAwGqfDx/VOI896zXE7Av20WmJ53n
         9MRj47BQIxXQAbNkhhf5bjGe3/Ita7BQpu2FbmszHueGI6H3lnQlPdc9AFdeyVwgFJgn
         zR0vJqEheiHP+5on8yPNNq8GabK8BSwJ16WkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761629643; x=1762234443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLpGC29sIJuMD8EW6D6+ekLf15xOznYOaep7iLxbnWw=;
        b=RBA0zCjR2Zt2LjKPIbbGIoJQVrS+S05Q9m8uLcP3t13rHoiRw43wlOcRZjDUaFqZnS
         CEXJ9xD4Y/g/JpT/H4FIABt92SRImPobgDJ0+1utKv0RO9r8CD6ezRdsifEXpZq68k6W
         RKfExTWtJ2GEUuqIvT8QQs9zLTRXDmf7I87hjNP6v/7nZe2T4zpn8VPo8LgJ105qMpVz
         6JIVIr/aiwPYBrHWJytP6fzBEQh63hINZAGGhOViKFIrwAGwL1VWa1c5lIeuwC0GbT1b
         7yhDFoggkjuWvAhv+BQ0tWFLxSYKe51cIbSCMNg/1ITeac8t47uO4ObFyaWIGIDzW3oH
         Ejnw==
X-Forwarded-Encrypted: i=1; AJvYcCWCE+KrGuy328NchTOhiGhLubEtaqjw3pF3yipL79iis4XF/b1U7EjqHozb0IabZ7aT93PR4wa1iNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGxBSsIh2CPJW7q4JVuszuEMugcRFbD1iiYBBdiHZBXTjWSefU
	290BWzCH0shk1fe0zdtOkTksRaCTedA42gMzneXpCa14ECgbz/zk+G0Ra307SZgBUlAvW2VN6kt
	ukYj1q6F5Jw==
X-Gm-Gg: ASbGncuin4+v+weRIv27ptqb3le0uTWZHh0NIFhDWidvfuCgoH4KrmdDZrcodhjgG+y
	fyZ7PWKAZGHHOHGEIUyKqmEIevfm5ROWNTLFR7twx2zzPGcD0cF2JkY/SVYZvNo8kImHHwCShRn
	woeZoUxxqhgFfqrYxDIHUtH4BDcZ8j0qAYtPNug+7N/L+qrbyMz6EMBWGjDqLzFCUESFUJfWOXB
	AhhEFYLGp/y20A8mmTjKJMzvxwd8UGsOBP/xq6u5m4Brs7kQDXG4HqalsjtvIXr3wY4OD4vU5Iy
	WnVz9Em+TJsmgeG0tpVAxxHzb4JTuhwChntwZ9lDYda90Suf/Zo0+VFsUzEg1WDk3eOv2HmlADn
	htUBa2TpMbYnJ0Vv5Z05wInwkT/W52imXgWdf/yDm+DKmtqIN814iIJLOa9UozA3eRzsyonxRf9
	wH6sR3ApoAqJg44uOMbFn7CZ69Nw2REJSQWSF8Hc7rGzNFz+2xXA==
X-Google-Smtp-Source: AGHT+IG304NQbquCzREGizQg9ZlRuqcCz7B07nD0p2tLc242g1kq/a3ry2S9k4hyvupsG/2zwL4Ijg==
X-Received: by 2002:a05:6402:5244:b0:637:8faa:9df7 with SMTP id 4fb4d7f45d1cf-63ed8cc16aamr2029396a12.29.1761629643017;
        Mon, 27 Oct 2025 22:34:03 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efb9fa6sm7857942a12.31.2025.10.27.22.34.02
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so1841902a12.2
        for <linux-efi@vger.kernel.org>; Mon, 27 Oct 2025 22:34:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+/4Bnf6ET8JbRr7XrccNMSHiPcRu2KNk6XbCGkr7s9zEI2mx58RzElA8jee88kK9ucZB21AFSn1w=@vger.kernel.org
X-Received: by 2002:a05:6402:2681:b0:63b:ef0e:dfa7 with SMTP id
 4fb4d7f45d1cf-63ed848cba3mr2102592a12.6.1761629641674; Mon, 27 Oct 2025
 22:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:33:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
X-Gm-Features: AWmQ_bkfyF7pn4e6fUY7bNVBhf2DrgjCvQYqt5ZlzergSjGB0BKOD2LLrniXl7E
Message-ID: <CAHk-=wg_FZnLha9Qr2sMQPXa1go4FPq2p5d7CnMoOnCimS2Wzg@mail.gmail.com>
Subject: Re: [PATCH v2 00/50] tree-in-dcache stuff
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 17:48, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Things get simpler if we introduce a new dentry flag (DCACHE_PERSISTENT)
> marking those "leaked" dentries.  Having it set claims responsibility
> for +1 in refcount.
>
> The end result this series is aiming for: [...]

The series looks sane to me. Nothing made me really react negatively.
But that's just from reading the patches: I didn't apply them or -
shudder - test any of them.

            Linus

