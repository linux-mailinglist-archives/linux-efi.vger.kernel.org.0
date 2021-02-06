Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF17311DC2
	for <lists+linux-efi@lfdr.de>; Sat,  6 Feb 2021 15:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhBFOiX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 6 Feb 2021 09:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhBFOiW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 6 Feb 2021 09:38:22 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A66C061793
        for <linux-efi@vger.kernel.org>; Sat,  6 Feb 2021 06:37:42 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id s107so9846714otb.8
        for <linux-efi@vger.kernel.org>; Sat, 06 Feb 2021 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=eF+Zw4jYMe8Cf/TQlc8mUYLnAXB2suwkNQ1AAD8uJdMVtDurKC4FmGQTqRGIw1zC7g
         WR08MHJ7GVn6kayimmYXIS7M8TxGr5uVZGwZLCBeCS+4/Tt+1Ogwj6s1lurr5NL5Qc7u
         LlBIxMED5MBtuzEMGKOB487tTkAEAcAHeycVljM8gyoPFyFIngdnI6SzhWqi7kGStZR/
         /U8Qp25XkqRWHaXA0jSchY4VzFPLto70zPBYaN0ICyRKhZp4cIPH6cTLxyXJEwnK0XPD
         JssdFnd0hU497QRL1NfB7jBAWeFDWkPpa6QmFUM7klOO9eiUGoDwEDMFIprd6NiwKmwg
         SBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=aAKl/MbSFgkq4UzSAaHvKKC4ZmJVo0NT2ybAHy5gcwPL1onD+LD77U6q8G4Wp8aB9d
         N3sZrUFoODRoPMDSq/Ulxy7NLq0vm0LgNcW8hQr1ZC4ufC5kE3fBUfhSDgpy1o+zM01J
         E0QHFRvKuWJ+JzQNu5TiRR3PWYxdCm5xX9jitLSioXYXPMZ4PEB1ePqAr5E0FpMwxPh/
         4l3W5ZuC7SFfm4b6zPNamd10sAsWKSJRbexOUeLisFbUZeAAqOE4/82Q0F3BojEShelw
         R8i5Qy5XP3GHrAtu+xaU7zoq7jo0475sr6XI7iK+d7TX0CzoM3Rp7j+kE2V436kFceNr
         fnyg==
X-Gm-Message-State: AOAM530MMFvp3VlXZTwQ8cI8i7MCTwaoJVJ1uTIkCXqHqWt1jVN6bQI0
        vUa1AGFRvMDNGrKJhcna6m88eRtY2+5Sxb6LENU=
X-Google-Smtp-Source: ABdhPJxDVsfeBHwFnFMHQFKGAVUwqAjL9q/GmzvX80aUDq2KqNVWnmIIe/3+3w80UbWChL5ghznrkDiuC7lBlk7pyks=
X-Received: by 2002:a05:6830:1318:: with SMTP id p24mr6858301otq.302.1612622261532;
 Sat, 06 Feb 2021 06:37:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:37:41 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:37:41 +0100
Message-ID: <CAO_fDi-7pnGewFxSqy1n1bfK7rJfhegbYNdD=3uCLDmjfn71+Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
