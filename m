Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B697549C747
	for <lists+linux-efi@lfdr.de>; Wed, 26 Jan 2022 11:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239773AbiAZKQi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 26 Jan 2022 05:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239767AbiAZKQh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 26 Jan 2022 05:16:37 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADAEC06161C;
        Wed, 26 Jan 2022 02:16:37 -0800 (PST)
Received: from [127.0.0.1] (dynamic-002-247-255-194.2.247.pool.telefonica.de [2.247.255.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C5B21EC032C;
        Wed, 26 Jan 2022 11:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643192192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVNkPXJP5m0LMBfgOcZbjMUKVGxtfPneUogvPQS5O+w=;
        b=GpqWSu7QeOyI8EWRRGsXT0XakZxdYvV4fz6wZh4HieAsvAf1sIYG3m7wkMGEX5HIbRP3Nu
        r9tRU1vSVAaTwyB7OFbWkypoP1QcFheajPazM4YrS4MDwtHySt25M+ftKVcDXHyIl1ThRF
        07uz4Xj91dtz6hKIGWt7VWte4FEDYnY=
Date:   Wed, 26 Jan 2022 10:16:28 +0000
From:   Boris Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     rric@kernel.org, mchehab@kernel.org,
        zhangliguang@linux.alibaba.com, tony.luck@intel.com,
        james.morse@arm.com, linux-edac@vger.kernel.org,
        linux-efi@vger.kernel.org, ardb@kernel.org,
        linux-kernel@vger.kernel.org, zhuo.song@linux.alibaba.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_0/2=5D_EDAC/ghes=3A_refactor_memo?= =?US-ASCII?Q?ry_error_reporting_to_avoid_code_duplication?=
User-Agent: K-9 Mail for Android
In-Reply-To: <8d89ffe0-6e34-a82d-09f0-9dd803fc256f@linux.alibaba.com>
References: <20211210134019.28536-1-xueshuai@linux.alibaba.com> <20220126081702.55167-1-xueshuai@linux.alibaba.com> <YfEEN0ATgS+TakLV@zn.tnic> <8d89ffe0-6e34-a82d-09f0-9dd803fc256f@linux.alibaba.com>
Message-ID: <5D5735C8-3922-49D9-9DD0-605746B5CCE4@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On January 26, 2022 9:26:01 AM UTC, Shuai Xue <xueshuai@linux=2Ealibaba=2Ec=
om> wrote:
>By the way, I have a question about review process: after waiting for a p=
eriod
>of time, how can I tell whether you have no comments or are still in revi=
ew process?
>

A good sign for when review is done is to wait to see replies to every pat=
ch=2E

BUT, there are other people on CC too so they would need to get a chance t=
o have a look too=2E

Regardless, you wait for a week and then you incorporate all review commen=
ts and resend - not before=2E

This constant spamming with the patchset is not productive=2E You're not t=
he only one who sends patches and wants review - you should consider that t=
here are others who would need to get reviewed too=2E

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
