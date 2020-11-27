Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98B22C605A
	for <lists+linux-efi@lfdr.de>; Fri, 27 Nov 2020 08:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbgK0HJ3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Nov 2020 02:09:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbgK0HJ2 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 27 Nov 2020 02:09:28 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B99620885
        for <linux-efi@vger.kernel.org>; Fri, 27 Nov 2020 07:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606460968;
        bh=4IVpaXGjQIQOa3Ihm+4FicrXYQh67KM11aL0xJA78Yw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pZyS9h+4hNab9DgTE0axZDSSecyJNSJelDAh0H58+alLJmwignPzgDqQl5mJPu/va
         sPuoa1CvUTQ2/A+nPU3C3Fmqx0aaHSBAEtxomhC3E//MloAtlZw86ZcHRVRix3QMjU
         MVLPsDWUu65aU7tQQT+l+dpXx/b8eX8i05JITy48=
Received: by mail-ot1-f41.google.com with SMTP id o3so3856829ota.8
        for <linux-efi@vger.kernel.org>; Thu, 26 Nov 2020 23:09:28 -0800 (PST)
X-Gm-Message-State: AOAM531ekpMv+pMgKuL+zsjQFrrLyC1DxJoDNSscyBMVNVKo9tKsrLp7
        mRZ3f8iTDAtaPK/5r3Yw7yLOhU6HKLMPkwFKdBw=
X-Google-Smtp-Source: ABdhPJytfiJhltIFVYxAmWxf0jsniQ4joN07S0GOffsonbkRXwkDa2maxCuy9D5ndhf/LZhcaQsKBN0+WJ/0QKO21YU=
X-Received: by 2002:a05:6830:3099:: with SMTP id f25mr4906867ots.77.1606460967588;
 Thu, 26 Nov 2020 23:09:27 -0800 (PST)
MIME-Version: 1.0
References: <39ab665-8ece-9a5-b4d2-20c8d989bbc5@panix.com>
In-Reply-To: <39ab665-8ece-9a5-b4d2-20c8d989bbc5@panix.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 27 Nov 2020 08:09:16 +0100
X-Gmail-Original-Message-ID: <CAMj1kXETsHVxo+tX9EaBOO2GPWvecTTfwNwZ=BtgKijGacc+0g@mail.gmail.com>
Message-ID: <CAMj1kXETsHVxo+tX9EaBOO2GPWvecTTfwNwZ=BtgKijGacc+0g@mail.gmail.com>
Subject: Re: Commit fe5186cf12 ("efivarfs: fix memory leak in
 efivarfs_create()") causing reboot OOPSes
To:     "Kenneth R. Crudup" <kenny@panix.com>,
        linux-efi <linux-efi@vger.kernel.org>
Cc:     Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 26 Nov 2020 at 23:33, Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> Found via bisect. The crash dump attached is confusing to read but the cause is there.
>
> Let me know if you need more info.
>
>         -Kenny
>

Thanks for the report. A fix has been implemented already, it will go out today.
