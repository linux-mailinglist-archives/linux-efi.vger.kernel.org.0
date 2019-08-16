Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9239050C
	for <lists+linux-efi@lfdr.de>; Fri, 16 Aug 2019 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfHPP5g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 16 Aug 2019 11:57:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42646 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfHPP5g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 16 Aug 2019 11:57:36 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hyebe-00047L-VY; Fri, 16 Aug 2019 17:57:35 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, tglx@linutronix.de
Subject: [PATCH 0/2] efi: Allow to auto-disable it on RT
Date:   Fri, 16 Aug 2019 17:57:27 +0200
Message-Id: <20190816155729.12518-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

since we have CONFIG_PREEMPT_RT these two patches allow to auto-disable
EFI runtime services on RT while it is still possible to override it and
use it if needed.

Sebastian

