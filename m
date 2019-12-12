Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A196D11D948
	for <lists+linux-efi@lfdr.de>; Thu, 12 Dec 2019 23:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731198AbfLLWXJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 17:23:09 -0500
Received: from mail-qv1-f46.google.com ([209.85.219.46]:45571 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730896AbfLLWXJ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 17:23:09 -0500
Received: by mail-qv1-f46.google.com with SMTP id c2so44665qvp.12;
        Thu, 12 Dec 2019 14:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=j32wVhvdVRFI2lvrzbdrSaW+WfrikRKVo4pqXuJJB8I=;
        b=EiPVAoGhXHYEikhwg8YpIRPFXZaAMMJG5rlh5Z2/MLQHstRWOvWkX4v6q2ju5EmLzy
         2Q6UP6aHunsMWDrG6W24AsETz9cy3y2DyZcAOpZbagB2k5ouQv1dbGGr8QcuWKbqJcu0
         VVi4oXN2xUTvPdVQSN3uoOP8xHJSyXyWMyTvv2hl1oWJOtkfQPskoK3XsJntCwA3xHGD
         Y+3opiL9LAYvBGvrWT4tjx9CefONao79KOQ8Kin33aWW55TtRLfCE10ynJWJytQujOz9
         +nlY3nAKw41IdIzgzhopdiVjw0w89jh1iEXOWCLPksdFubYIRmd8rtA5EPG46h5OCBEC
         pSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=j32wVhvdVRFI2lvrzbdrSaW+WfrikRKVo4pqXuJJB8I=;
        b=P3UCaFjjp4XSTULPZB+k4G2tHMNC37GsfVQF9zIP9ZVnne99O0XhTYlhtkZA8NgOb3
         t6Zky0kfjD0fQlgCnJDNgm2cXK+StRaAITrk6/kOKxNi9VpEU8f2A6AL09tLO6APSTqo
         n0wLC+XleXI7DGxgMuejO1Ov1oBmmnJVFPuBYNTb2m4f8rEvq2hODdrsIuCOtTe+3iXZ
         /cPwTk+b+2F7FW4OTFAhSnu8yMZemVicGfU7bTcbGcNhqinrqOtnhI79a9Zok5ePr2EE
         33S00QAGFiIGpdlcmEDzS88aBshdUalxWFMb8DluRJ1l0/3DF1+fXoLbKUoF7+LaO/4n
         gMEg==
X-Gm-Message-State: APjAAAWxJd6sNpBPsXtPMztQWAxd6O7M/rgUUOtmItjrSljjAcKAdY38
        FwOIUQ3aIAwKmWIwaUf+nDo=
X-Google-Smtp-Source: APXvYqxOCXl83hHTWcOsd+KJ8Wx/M5pVbl3wqVVZAH+hzz3X14F3jdTyki3i835vM5QAnTyM6cVBYQ==
X-Received: by 2002:a05:6214:1493:: with SMTP id bn19mr10834706qvb.83.1576189388182;
        Thu, 12 Dec 2019 14:23:08 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f21sm2579468qto.82.2019.12.12.14.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 14:23:07 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 12 Dec 2019 17:23:06 -0500
To:     Ard Biesheuvel <ardb@kernel.org>, Eugene Cohen <eugene@hp.com>,
        Matthew Garrett <mjg59@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: efi/gop: do we need to check ConOut any more?
Message-ID: <20191212222305.GA10385@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Since commit 38cb5ef4473c ("X86: Improve GOP detection in the EFI boot
stub") we check for a GOP device that implements ConOut protocol to find
our primary output device. The commit log says that this was done to
avoid problems with the ConSplitter device, which exports a virtual GOP
interface. The original version by Matt Fleming checked for PCIIO
protocol, with a note that says there are some Apple machines have GOPs
without hardware, I assume that that was the same case, GOPs from
ConSplitter.

However, since commit 540f4c0e894f ("efi/libstub: Skip GOP with
PIXEL_BLT_ONLY format") we skip GOP's that don't have a framebuffer.

Looking at the EDK2 implementation of ConSplitter, the virtual GOP will
advertise a framebuffer iff it is attached to exactly one GOP device, in
which case it passes through all the information. If it is attached to a
UGA device or to more than one GOP, it will show as a non-framebuffer
GOP, so we will skip it anyway in those cases.

Given that, is it still necessary to check for conout at all, or would
it be enough to rely on the framebuffer check?

PS I hope I got the latest email addresses correct for everyone
