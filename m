Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EE0417634
	for <lists+linux-efi@lfdr.de>; Fri, 24 Sep 2021 15:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbhIXNu7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Sep 2021 09:50:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346319AbhIXNu5 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Sep 2021 09:50:57 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632491363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DQ/wolWOLlBQu/7nYH09rH+jxV9pXO42MbcHiD0SDQE=;
        b=0dPvt8I69aKmJMDKTe3LUJI7+Q1I7sMYr7ksuc9wTrFfdyKEk2aZOB/wuNYhFAXK35VhHq
        pGslEf8HlaCYppNks0IqWAeeV4GJIcMUOf5cvslvG52SwxlvekH8psHYjUz0u7zyiwSiKH
        uKxnqKtgvEF33aTvGz/U4tS0if10JdvjMVaHkg8G5LU7r91eH9CTFgOb7vbVyyuxQje0YB
        IdtI0Ecj7fQ+QY0eiMyWlD0IeZEWsITEBPO72JNV37s68UfykiLZdHfNv12shUZ7kYXqWo
        Oe6C32N0lvdvGt4r08j2+NJGNPvpIP5GWZNae8EGMdKUwVVMTSPvIBhn4kaa9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632491363;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DQ/wolWOLlBQu/7nYH09rH+jxV9pXO42MbcHiD0SDQE=;
        b=jLSIlvO8XADyy5a/A6gwlSkjS0usalAamDTJDlUDNCEDSE+CiPk5AHboraMvYR3+lpC+oW
        yxsYFUOzC3uTr2Cg==
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/2] efi: Disable runtime services on RT
Date:   Fri, 24 Sep 2021 15:49:17 +0200
Message-Id: <20210924134919.1913476-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

These two patches change the default of EFI's runtime service to off on
PREEMPT_RT and allow it to be overwritten in case something needs to be
done like changing the boot-order or so.
The reasoning is to avoid unforeseen large latencies, like the one
observed while using efi-rtc, by default.

Sebastian

