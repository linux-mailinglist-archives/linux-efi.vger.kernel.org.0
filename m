Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A4CECCDD
	for <lists+linux-efi@lfdr.de>; Sat,  2 Nov 2019 03:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKBCX5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 1 Nov 2019 22:23:57 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:41787 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKBCX5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 1 Nov 2019 22:23:57 -0400
Received: by mail-io1-f52.google.com with SMTP id r144so12854959iod.8;
        Fri, 01 Nov 2019 19:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=O68DoQOs3i3Yso0XcaqTyteEVBiIQd30TmH5RmmBRxM=;
        b=I9nhCs6tq1vc/kaQQk1pWmAemKkYkyS+Opsgpl3uNbj37iFTKBhMfAXkp0+r3QgSsh
         PIhE1uw5dWbmmStGpY2Sr0pPywqq8/hetaw9aQAJw7l5FInh/6dgcDfNYm9RvQK/lKps
         sceBb0QOx/bR6TGvQvDZupKb3Af9L5oRXZEYRL5PAWldX3p2leem6IAqtJiJspzZMpNw
         ONMe3fXyfwYoaifdC5BQpVyhfds6YW+18KOPBL/Ir01fWSU5yiKlLsgB+VQYlYpPU8xy
         U8W732/oZ0Na7SIfx5AS1nS65x38R0Ap42r7fXY8zFVII3AfKXThehhe0FtLXI3IfbIf
         teWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=O68DoQOs3i3Yso0XcaqTyteEVBiIQd30TmH5RmmBRxM=;
        b=ijGkj0NklzzkFYdnCOOzecTN+nz5CkoZPGlhUPxvu4e7QiH25rJWG5OrUfxeAd5QyR
         wnXHa/LGkJ/mKNc6UtS+I6z4iARY1M+Zvm+tVdmbTO/4zpKhk28lgSH5RcdihlrDKlh2
         NJJc0dcPXcc94sC1TGKDF4lk6DmpJUkeC+JXsXEBgA3b7J7Gy5tI/M6MvHONsnJM+rsg
         7w6La0NQ8K+x2m8iWY5T6XEYq5EJIh+dcGwEGTb7PrPROL2/f6rsyDsWTUlaZ5R+ME1k
         Y4pl0DhanqqLaKkjVMBaMowhL4G+8qNzzxYiIrNQ3rvdo8eCp/xlZOE6Lny9S7G/HSXY
         BBZA==
X-Gm-Message-State: APjAAAWl9ZbCIVMsi/KIz+piJt6zW5r89ZK2qWzZyBTcu5hN/bArlQUt
        7oLQFWP6WN5DIdDwdk9DiHe1hMbeaXTbJZh/ttFAjeyx5Ss=
X-Google-Smtp-Source: APXvYqxKtJYSmxLY3DeUDOXq5em1FoMXLX418MTJq33ld93stNrEA1owjG+0m2UxXWy1P4Oz/8o4sRBKZ3FniP1lnwY=
X-Received: by 2002:a6b:7c09:: with SMTP id m9mr5697513iok.139.1572661434470;
 Fri, 01 Nov 2019 19:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOzgRdbjf7AkxXtgQ_ZxWU_QW2XqT+=CpSTBt0_T10+gynXtTw@mail.gmail.com>
In-Reply-To: <CAOzgRdbjf7AkxXtgQ_ZxWU_QW2XqT+=CpSTBt0_T10+gynXtTw@mail.gmail.com>
From:   youling 257 <youling257@gmail.com>
Date:   Sat, 2 Nov 2019 10:23:40 +0800
Message-ID: <CAOzgRdYLYB5eB2aNiGL7wuS5tvF7M8cEWiOqLFKcnMsWOe=zNA@mail.gmail.com>
Subject: Re: x86/boot: add ramoops.mem_size=1048576 boot parameter cause can't boot
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

only add ramoops.mem_size=3D1048576 boot parameter cause can't boot on
my device, stop at booting command list, no anyting happen, no dmesg.


youling 257 <youling257@gmail.com> =E4=BA=8E2019=E5=B9=B411=E6=9C=882=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8810:18=E5=86=99=E9=81=93=EF=BC=9A
>
> only add ramoops.mem_size=3D1048576 boot parameter cause can't boot on my=
 device, stop at booting command list, no anyting happen, no dmesg.
