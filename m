Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBAD12D44A
	for <lists+linux-efi@lfdr.de>; Mon, 30 Dec 2019 21:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbfL3UKm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Dec 2019 15:10:42 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42872 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfL3UKl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 30 Dec 2019 15:10:41 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so25773882qkg.9
        for <linux-efi@vger.kernel.org>; Mon, 30 Dec 2019 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0rL8ME0bpAcMgOofRgvyKSa7hNalbG6Q1Lmlac5MZko=;
        b=HSFHc4Z/kraJK5C2yFbeRyWMZJD5Jfh7h+YNllbgK/v+IgtMmhX5tCBUZZS34HsiN7
         oT1lWAqx2gdGVkSm6D5iX5z8z1AeTsv3TOhRiUmRIjoXfr6yCxd7EY/JA92vI/GHP+Wz
         Rmpk36LwfsCjXDwieNixoxiKc23Yll1aNgj4P1vnovPd9mtcqqX+gTX3FAFO24S0qWZq
         yqBDqaI1apGdqZn98m52WFVyKq8AaxYtXfhyVZlFlSL3EjoNK0gWNhwKIubVner5Ldri
         i47k2inDoDJaG5LVttDmVUdI1dOk3jSBp95mQ2Etnqn7CPOo9kVd5ohKlonnHfc44Otr
         XeTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0rL8ME0bpAcMgOofRgvyKSa7hNalbG6Q1Lmlac5MZko=;
        b=fOACWb02xFPlLxrSEaBMqwIprqQraPUCVZ80fcWG/dI7Ll2BvoUn0epPjHid321L5J
         Dm/JE/RAXPKmcv0pD8VGfQDKxwZ1Hoxwb87MU7XTFW+yCPHjp+N2JhHSqt5Pc+STVsg8
         XjFGYjz7hGzxdNNKJaJedyrFxL9xpZnmS/H3CrkIv/d4bwxm14B40oAnVP2SzKK1OuAn
         StHZf73SHRl2TqXQ3v+54b25P6sAO6yApkk+mepJ9vpziTTWg+NeUV3SgioE+/uTht55
         Kgw77kpVfRNJec4iLAA5O1WLwlOBy5m1wQ9hns8hDXPOXEQSue/ZPSENEmm/Cri2UTvR
         l1wA==
X-Gm-Message-State: APjAAAUFW6zYZAvBwoFlRzd1kqFMiUTfW6uy2TG0e8OGcR6j/3bnwByL
        0v5aXRNMOaojUWj9eVMXvzqhoMbL
X-Google-Smtp-Source: APXvYqxeOoCCKudh7Lb3TRmQGPsCHFyvxlJw54TdRJTsdY3lUs0s5XeI3mr1K1fWRuHtaV5Vf+se+A==
X-Received: by 2002:a37:454d:: with SMTP id s74mr56494934qka.104.1577736640925;
        Mon, 30 Dec 2019 12:10:40 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 184sm12711860qke.73.2019.12.30.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 12:10:40 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 30 Dec 2019 15:10:39 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] efi/x86: Check number of arguments to variadic
 functions
Message-ID: <20191230201038.GA2593547@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191230200011.2589934-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is on top of https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
