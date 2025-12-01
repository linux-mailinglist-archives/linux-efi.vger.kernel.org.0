Return-Path: <linux-efi+bounces-5742-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 809FEC98CE9
	for <lists+linux-efi@lfdr.de>; Mon, 01 Dec 2025 20:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E252F4E1BB0
	for <lists+linux-efi@lfdr.de>; Mon,  1 Dec 2025 19:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DCE23909C;
	Mon,  1 Dec 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b="YA5tU3cZ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819F622ACEB
	for <linux-efi@vger.kernel.org>; Mon,  1 Dec 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764616201; cv=none; b=oP9gr8mf5peTEWwULo/cW8zX+YyLwjU697+Zh/oi52meMiHaMpr6ckKChFKDh0oWdAAKfGaX6Y4VxWpCJuiLVgyEFf610vPBxpPkxM7U6J7PzKK455OHYcBakyKZtPBsvjyemzHbdyQQNYHGw7nPklfUYH1aJpmWUMaOt2iXANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764616201; c=relaxed/simple;
	bh=SVRmWcU4reDKs5HHBiPJg4YERntaC6a4bjb65WL5Ll8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LrpmN46uegbyKrhvNklIa8eF1/S8L7gZhWWDrTCZRCxwljClYsXAkLCKDsNjF1JyfNlxO4rWJN9dCdyov3npvxwiBNmLDKOaH+3otZbOqQfgFRPLOkENgdIvKh/DIgxQYXg733/yQ1pM7gfT6eoMMjTiXC6Fsfi0187kHHrjGhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com; spf=pass smtp.mailfrom=it-loops.com; dkim=fail (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b=YA5tU3cZ reason="key not found in DNS"; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-loops.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so1354789a12.3
        for <linux-efi@vger.kernel.org>; Mon, 01 Dec 2025 11:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=it-loops.com; s=google; t=1764616198; x=1765220998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9lyjwDqKk+QqPVACOcdksqjAbpRjmOBLHeLAVEc6wc=;
        b=YA5tU3cZ+g3sK66fC72nxQy9/2Bf9ohExSHsHHJTV8YILVHuCUrfDAxEzrXgceadhF
         Bpb1Mf6R76mjtka8lO0+yk/AxMa5oQuWTE41VHlhnoWHAFNN4pxgbolpBKSAWKGdcOLJ
         C1QGNUmMgoOO14IKpjGyLAgEEozOWISy5qr2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764616198; x=1765220998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9lyjwDqKk+QqPVACOcdksqjAbpRjmOBLHeLAVEc6wc=;
        b=s7TukXHkRy4Nr8siEICo6AqUeimta7dArSmenEnO1C7FunI7hkza9qlFXChGCuhfH1
         V8QBpCVU+Jl4t1R+HmprFMMw86jiPtInyXouQKHIU14M74rhfete4znTTMICHn4IJYyJ
         cnqHCnPrGiJj7y0JRy+wWxQjQwTY2pjxiv73llRiobSWstjmXlVqzNxUSTNl97D9fNGo
         olCc2crTEuc0vDJytaB3ABTFXCnAbJXgCe3f+iOyCJhgxVR+RrT4JvQJb24J7PlpdZYT
         +8XV84A8R4G5QlXvfXoRc6jLqZUgHMjxQArjEJUb+A0NZXCk1czH3JyT9Nzft2PRjxRO
         YPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUervr9bGX6PCwWz6WN+C4/W1Vq487n36VS+1HcKAhH1xlnkXZ74m989tJNkUKrhBMcQ8qCtO1hjf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDB2lXbvpnZqwB0z/U2NNn+0nzWMuya9AzhF0NBF8WkZnu+j4s
	ZtLURKqLdRwgT1qo04Snf1YsE/NU3luNCsDpcZyJmbP66VYYfzscKDRTxmF7ETracy0Mpk+UzrA
	vuc3ySdRoXOckRUFBNrLbxSq9JJ27kuW1/OVsNRLAkg==
X-Gm-Gg: ASbGncuGb5YDB6qlPkOpFXbvqX9CGNkFX5ELbo0BiqfxBGdiXDaenxl7+8hnCZL3spW
	/lwztHK7KlSlIx9xLf2xOn1sC7kbRYkEEPVX/wv4yygLJAIxUfw1OXLtS2XO3lk8FFigLc+NVRy
	GT6Z2jgMzGyASKf7db8vKgpVy5hGEZNEzgckAuC9XJ//RluckYNef2jfW39slY3nkvig5fWS96J
	OuH2DA5epoebaHQ2F5J7t/tcWSSqC8VlmVDGXwfWD3ZGcmATLEDm41BuZ97TZVsvqpVh5lh
X-Google-Smtp-Source: AGHT+IGOTyOpca8Bkm84/CeGDYKF35ETxinW7GVj+Vtn2G6U42NT9STdY6vw7lpQ0JlDfrhENEba8b6RRkfXj6TIzFg=
X-Received: by 2002:a05:6402:2353:b0:645:d578:13c3 with SMTP id
 4fb4d7f45d1cf-645eb2b58e2mr24564984a12.26.1764616197808; Mon, 01 Dec 2025
 11:09:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
 <20251120055748.GM2912318@black.igk.intel.com> <aSGTghJyX-u-leL6@wunner.de> <6e7aa10e-9938-4ab1-af14-b3d2906c211a@panix.com>
In-Reply-To: <6e7aa10e-9938-4ab1-af14-b3d2906c211a@panix.com>
From: Michael Guntsche <michael.guntsche@it-loops.com>
Date: Mon, 1 Dec 2025 20:09:46 +0100
X-Gm-Features: AWmQ_blakwbWOT6KrL76uyA3F8k_mQ8r2CJl6T5K_SnWqDq6g2_2g2KzHQYk0KY
Message-ID: <CALG0vJv7ZA8byAF25pKqh9fEBpfgbXk+cAE6s9K1N6ZvVRroUw@mail.gmail.com>
Subject: Re: Oops when returning from hibernation with changed thunderbolt status
To: Kenneth Crudup <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-efi@vger.kernel.org, maarten.lankhorst@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[cc +=3Dmaarten.lankhorst@linux.intel.com]

On Mon, Nov 24, 2025 at 7:02=E2=80=AFPM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
>
>
> On 11/22/25 02:42, Lukas Wunner wrote:
>
> > Also the photo shows a UBSAN splat in drm/display/drm_mst_topology.c
> > 220 msec before the oops, maybe it's related?
>
> FWIW, this sounds really familiar (resume crashes if I changed TB docks
> between suspend and resume) and was getting an OOPS there I'd bisected to=
:
>
> Resume OOPS from f6971d7427 ("drm/i915/mst: adapt
> intel_dp_mtp_tu_compute_config() for 128b/132b SST") if MST displays
> disconnected while suspended
>
> ... and this was fixed in 732b87a (Fix determining SST/MST mode during
> MTP TU state computation) back in 6.15 (which IIRC, is when your crashes
> started happening).
>
> I wonder if this is related? Maybe reach out to the i915 guys?

I tried this now with 6.18 and got the same issues, now it even fails
for me  if I unplug the dock while hibernating.
The last entry I see is the UBSAN message and an out of bounds index error.

