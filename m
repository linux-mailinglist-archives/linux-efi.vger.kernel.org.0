Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1054809D4
	for <lists+linux-efi@lfdr.de>; Tue, 28 Dec 2021 15:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhL1OKC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 28 Dec 2021 09:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhL1OKC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 28 Dec 2021 09:10:02 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3B1C06173E
        for <linux-efi@vger.kernel.org>; Tue, 28 Dec 2021 06:10:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bm14so74316302edb.5
        for <linux-efi@vger.kernel.org>; Tue, 28 Dec 2021 06:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zwa5SmF7AqJ7b8ziq0P2tazEHmZcmrR0jeKQIZMxvV0=;
        b=nAYfxbW+UjtrRYnJ6qW+UZji2MJ1Ao2CSM5NC6/jJsJu6sET8TUvVCb4M0x0s3KXb/
         28MPjNQRH63gN4MsoqVggE2E3Zs7IHSrCc/raUONXShOTiDw5/VgWwMZXNYegyx62Exn
         PGWiMvrpwgR/uCZan8SF9YD4yKcDN5keXnJ8ldNYQswt9PcqaXRq07FaPW+QI6/J+zDT
         j18UU6VfqawnVWze+jNuYDW7WL1m+TX0rj3fxTWiRuPIAmBH0Q9i1u8YMR4kScJlne/b
         J/9ziTaSCf5/FxObvzIjYSn8qfahRN6cMq1E5aV/oo2FCXnMOjZMaf/oApfOF8QIvI5k
         DVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=zwa5SmF7AqJ7b8ziq0P2tazEHmZcmrR0jeKQIZMxvV0=;
        b=acYEtjtilWcaUVvoDiNL1XKdp/dQHclwRF6U84Hos6f0fLHhN1AmGaukQgezYwvykt
         JsuYob5gpql2x6YXF9d8agq/OB3BcuWNZ9J+pxFxkMG2QayRVObcnwEWdHaA5hB+NwFO
         ctOG4e1TXWsvwCCgHN0p3Hb7nwRrfK+scFNiPm5DtBduoROsDzDMYuDwtuiL9v/GBCs2
         Bg181OLokVNgE+h+zxrvxroV3vWwxxTyWtGfvYjsEMK6LcgTac8NdwHojU7HKmRFQVm4
         j9+lFJ8Z1EVuAD7pKD1KbhmZ/23SLhuDr6lv19HvKJM1nF9Pv0eSTzeRH4/Djm/HOoQO
         lSwg==
X-Gm-Message-State: AOAM533pmsp9+CPsSU/Wigx+63wvg29QuTd/IXe8704iPxXGAPV3UOGc
        qyiNLgLI2TAIC6jPHFXzwn7iVh8/4CCzW5+k1xY=
X-Google-Smtp-Source: ABdhPJyAWB85JzxsfzcGZcym0/qN2kIPBYTkbMTqTOs41NHh44UIem4lSl9HEJMz6j8ho5lB/nudjGF6Ng2+d8KscqA=
X-Received: by 2002:a05:6402:35c2:: with SMTP id z2mr20989808edc.136.1640700599850;
 Tue, 28 Dec 2021 06:09:59 -0800 (PST)
MIME-Version: 1.0
Sender: mrsdanielsmarina2020@gmail.com
Received: by 2002:a17:907:6da5:0:0:0:0 with HTTP; Tue, 28 Dec 2021 06:09:59
 -0800 (PST)
From:   Jackie Fowler <jackiefowler597@gmail.com>
Date:   Tue, 28 Dec 2021 14:09:59 +0000
X-Google-Sender-Auth: Fq-GA9VKL47CG3jQ9qSLXlrhLYU
Message-ID: <CAKV9mijpmwGhs43EBOozg5NrktjSUK87Xw_dXn4a+01s_noEJA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Gooday my beloved,

 I sent this mail praying it will get to you in a good condition of
health, since I myself are in a very critical health condition in
which I sleep every night without knowing if I may be alive to see the
next day. I bring peace and love to you. It is by the grace of God, I
had no choice than to do what is lawful and right in the sight of God
for eternal life and in the sight of man, for witness of God=E2=80=99s merc=
y
and glory upon my life. I am Mrs.Fowler,Jackie,a widow and citizen of
Canada. I am suffering from a long time brain tumor, It has defiled
all forms of medical treatment, and right now I have about a few
months to leave, according to medical experts.

 The situation has gotten complicated recently with my inability to
hear proper, am communicating with you with the help of the chief
nurse herein the hospital, from all indication my conditions is really
deteriorating and it is quite obvious that, according to my doctors
they have advised me that I may not live too long, Because this
illness has gotten to a very bad stage. I plead that you will not
expose or betray this trust and confidence that I am about to repose
on you for the mutual benefit of the orphans and the less privilege. I
have some funds I inherited from my late husband, the sum of ($
12,500,000.00 Dollars).Having known my condition, I decided to donate
this fund to you believing that you will utilize it the way i am going
to instruct herein.
 I need you to assist me and reclaim this money and use it for Charity
works, for orphanages and gives justice and help to the poor, needy
and widows says The Lord." Jeremiah 22:15-16.=E2=80=9C and also build schoo=
ls
for less privilege that will be named after my late husband if
possible and to promote the word of God and the effort that the house
of God is maintained. I do not want a situation where this money will
be used in an ungodly manner. That's why I'm taking this decision. I'm
not afraid of death, so I know where I'm going.
 I accept this decision because I do not have any child who will
inherit this money after I die. Please I want your sincerely and
urgent answer to know if you will be able to execute this project for
the glory of God, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of God be with you and all those that you
love and care for.
I'm waiting for your immediate reply.
May God Bless you,
Best Regards.
Mrs.Jackie,Fowler.
