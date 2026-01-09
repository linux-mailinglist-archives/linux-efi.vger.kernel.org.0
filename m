Return-Path: <linux-efi+bounces-5974-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF10D0810F
	for <lists+linux-efi@lfdr.de>; Fri, 09 Jan 2026 10:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A18E1300EBB3
	for <lists+linux-efi@lfdr.de>; Fri,  9 Jan 2026 09:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738853314AB;
	Fri,  9 Jan 2026 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VfLTVZBP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VwHKfKC6"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897EA330B27
	for <linux-efi@vger.kernel.org>; Fri,  9 Jan 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949383; cv=none; b=e4Q3g7/EHevehuAgiepUtGyT94y2yztg6r7e++zq/VUfsy53hTIuzdHCu05VvJz6qzBwRmnjVNgpp332QGquEoDHFDFWn8TyVNWyJPcZ5B/XO9/hQo8OsPVq/1FJhkxc+xe4vUM6gFPd6ncDBA3rZUhl4tQipnpbPUyHXdPmlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949383; c=relaxed/simple;
	bh=lI3vWvKnic19vdOGJ+3N9CWmKDFS54Hz3RuRyiIM/kY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MSCU5yDOaUCDVyFqhm3gliM6oFrGIlYn8bX+ig0Hi+qZkn64mvR6gjHTmymWiCZ2kIKSnIul5lMFDlxH+G3DEhXAqQqhYW6+Jve02B/83Jz4uMqOzS04i/yIuOuEqXkM2bP2IhxHtONHChIO3yAzzjeoSGNGEnnC4qbgmeZ5Fzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VfLTVZBP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VwHKfKC6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6098XNjg822710
	for <linux-efi@vger.kernel.org>; Fri, 9 Jan 2026 09:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7thsI61iVOv
	UNh22HCK2qAPj5NTxS3xwSRoZruWKBf8=; b=VfLTVZBPEPJTcnh8S3GgsofRT+w
	K2VnuXxT19d5er1dKE9/9I/YhEwfzUD5geAJdKo7jmY73ZnBBBrRp6JTHEuRfcTe
	KmhB2Wi1azzpWV7B01AYUJzcW6U5Ofjz6uucaD+OhfAw4IFouAbN5NaD6PUcdQpS
	6GkKhzUzOTfO21wj8QzAR6HeMtqFoPbRb9Zbwr/otMxGvh1fGgh5xFMZRDb+MxSm
	cOHUvwY5QHy9ffHxrjUBCHJgLd5QR2TPGF2sdGhkfF3c3WCJoDhD3FftveWjw/TR
	oLv+KdDFX2nM9zSkGzPMmMX/3OZzZaImIHhdt0vmQfdHn6WrUzozXtyegvg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjx94g3bn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 09:03:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7b9321b9312so7417573b3a.1
        for <linux-efi@vger.kernel.org>; Fri, 09 Jan 2026 01:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767949380; x=1768554180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7thsI61iVOvUNh22HCK2qAPj5NTxS3xwSRoZruWKBf8=;
        b=VwHKfKC6xr3tGQKuKdGKEfVxmTBgGh/zTk1DsgNROL2pUnFuk53IEDHPa6xJBGhDJr
         CkHJVm5fA+qLrDsdpYWgjmy4WcdVSpssOmpmiD158XhXCGIwHYjGrGOkw0l857hiGiQE
         MMbm19tlGkjm8O9hibDEdI0EqIFeTivRINHUImPBFfGuvYRzNFQsC8uUdHqM7VT0oQ+w
         pu7KwXuxMwsvNV7MiUL3og/t2uL6bUxslr3cOsHYFuO48CrwQPO4nnhzdBVlC+pVMedl
         k3lSc63eUc/Dxi+KwVYfgpkdvP7YQ97Lc8fUiE9TeWmU6eX13t2ap1JzaCT7XhiG2zpi
         6LIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767949380; x=1768554180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7thsI61iVOvUNh22HCK2qAPj5NTxS3xwSRoZruWKBf8=;
        b=G5Gwcz7uUnFG3ydPRyElIkoxCuR01BAWuTyrMwsbBTfbcBBCQWYhdkJ4mdFn/xzqv/
         lFIb+ktjaV6sQPuVo0C/3evPnPxR3QNmfQUQUF+WKBxl0M0zMY3YgzKQwRm2bGFelZ9r
         BEDQmmn8eEoGFkJOStO5WP8lrW9/9w2/aJVME2hkCYCuYr/+7lZ522Nz2Iks6aneOjs0
         lfT6TSHFn0xZUeo50q8euQmI5rarDzOHN1CUZDuyCeawIhKL6/3Qqk6+h4C/mgS3KxK6
         IeIl0B2/G1FaqGxkxPp3KGssgIrkV+pO4uAKQoFGiB3zErFSYxfj4DT/cMOFfWFRMuib
         AKBA==
X-Forwarded-Encrypted: i=1; AJvYcCWLbWBeiGfeQdYYKdDCGz+cGVKBttnzo3bZMeW4qOj4LTrrJheR9VfC1wcUmn1tqhStgR2yXuMKb0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVyCw29e8bSd1+EyZVWTU2MMdIrDB8HcQWKOPfFPsO0LOzyXNj
	HQnKV9PBdNL/qJmvg/hr+cDglCtfh1GtLufQyZ8B65n4YozPJlwajiX9q0ugC2RIRkZJfYbOJkr
	2f17BUgk2Ly7jVgOIkDUYCvD28m2TL+U31yPnq11QWEBOwBdr0rlsewscGNcOeLU=
X-Gm-Gg: AY/fxX4xSFp7mbJGVpvAi42ikXpAasaAUnJ1825CR/qua6scuH8dVgk1aj8UpmyLch1
	rpYwT830BPpdmRLU7vaG/q+FN6D/U1+eGxEZZXaIuo3476MDygKB8TcdLEGn3PAyokaj0W22ge2
	QsssVPZq/52v7TMFW/ggkQtD2RPQqhXwc7jjV6CjIqloP2FCJf1eckUqnPUnC1ZPAxkCJ7qX2tv
	+CVouMio34oS1q6Po+fEc18khDnOKV7HxaNgIBfdSeiNB5eM0pUf3U6yKaTGe1v2qR7vDaMohef
	koXI0n+r8nUqM+c0V+LG2COlMo8SbvVKo9ffNiWKfR+d0hCi2npmvpZVeawPeA6rZVhpHhkBzs6
	jGafFv9a5KB+YW4N4HKhM0tiPr32ckml+lCd+Ad1PlhHJkIIklfld44Aqia20rw5B+RZ1AEpV2A
	iAEYouaG9yNYTMzjJj/hjcsQ5v/r/u9b4wXg==
X-Received: by 2002:a05:6a00:348d:b0:7f7:3749:d97c with SMTP id d2e1a72fcca58-81b7dc56e8bmr8974797b3a.22.1767949380069;
        Fri, 09 Jan 2026 01:03:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTMYGiUv7Wddy4gOxN3iVSD4nKGS7B9cg7aceUCQy0Uhht1CbC13+ZGNry/QY+i6KtaL7fHQ==
X-Received: by 2002:a05:6a00:348d:b0:7f7:3749:d97c with SMTP id d2e1a72fcca58-81b7dc56e8bmr8974749b3a.22.1767949379557;
        Fri, 09 Jan 2026 01:02:59 -0800 (PST)
Received: from hu-himchau-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-819c59e826asm9831562b3a.54.2026.01.09.01.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 01:02:59 -0800 (PST)
From: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
To: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linux.dev, paul.walmsley@sifive.com,
        palmer@dabbelt.com, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
        cleger@rivosinc.com, robert.moore@intel.com, sunilvl@oss.qualcomm.com,
        anup.patel@oss.qualcomm.com
Cc: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Subject: [PATCH v3 06/10] riscv: Add functions to register ghes having SSE notification
Date: Fri,  9 Jan 2026 14:32:20 +0530
Message-ID: <20260109090224.3105465-7-himanshu.chauhan@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
References: <20260109090224.3105465-1-himanshu.chauhan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RN2+3oi+ c=1 sm=1 tr=0 ts=6960c444 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=2d44Z0_5zRK2QUa08RUA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: zReQF-maNi4Yw0rbup96Bti-gF5QVJqk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA2NCBTYWx0ZWRfXxLmEgI3l30VO
 b6WKFrb/vvTIXlMQtS8nCiH67vX8FeJ6WwGx2E6ZSg2VWNCkSJjOHRVVZUJRTkLehb/SE7NYlBM
 YcuNyFu41PTIAKjrqyD3+mphqgsw/t3PHs4dI2Jn4SNyveTEVC2QItVd2AvhlLNMQ/n0xVNuyor
 c4JNgxwp6kWueVHhZdTCIBQtp1+yn4A+NHwXCKNvCT+I+//tbnqAIeRoq+9e44t+xC/I31e70nE
 jsgWx1LBO+RxvbgSttM+t/P4RdI6or72KiMLXgtNpdNUAlRn9sZXqa/bTwHSOLzD7viJP17diN2
 owMdohGgb1S6UXN6T6yOip440OXRp+UAwtOF3eXfwQRWZVcy4E/ibV7Nu3dIloUycGjuyAov7ml
 nZEAfuTl815n63az+8WWklBVkjIj4tyP46Jpdv3HjI8dw7WI17ySJYaCvY247Ij8Yv7WTc1wzUO
 OUE8DxReGm38li85KBw==
X-Proofpoint-ORIG-GUID: zReQF-maNi4Yw0rbup96Bti-gF5QVJqk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090064

Add functions to register the ghes entries which have SSE as
notification type. The vector inside the ghes is the SSE event
ID that should be registered.

Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
---
 drivers/firmware/riscv/riscv_sbi_sse.c | 146 +++++++++++++++++++++++++
 include/linux/riscv_sbi_sse.h          |  16 +++
 2 files changed, 162 insertions(+)

diff --git a/drivers/firmware/riscv/riscv_sbi_sse.c b/drivers/firmware/riscv/riscv_sbi_sse.c
index c7f29b10cdfb..ee288a0c1680 100644
--- a/drivers/firmware/riscv/riscv_sbi_sse.c
+++ b/drivers/firmware/riscv/riscv_sbi_sse.c
@@ -5,6 +5,8 @@
 
 #define pr_fmt(fmt) "sse: " fmt
 
+#include <acpi/ghes.h>
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/cpuhotplug.h>
 #include <linux/cpu_pm.h>
@@ -692,3 +694,147 @@ static int __init sse_init(void)
 	return ret;
 }
 arch_initcall(sse_init);
+
+struct sse_ghes_callback {
+	struct list_head head;
+	struct ghes *ghes;
+	sse_event_handler_fn *callback;
+};
+
+struct sse_ghes_event_data {
+	struct list_head head;
+	u32 event_num;
+	struct list_head callback_list;
+	struct sse_event *event;
+};
+
+static DEFINE_SPINLOCK(sse_ghes_event_list_lock);
+static LIST_HEAD(sse_ghes_event_list);
+
+static int sse_ghes_handler(u32 event_num, void *arg, struct pt_regs *regs)
+{
+	struct sse_ghes_event_data *ev_data = arg;
+	struct sse_ghes_callback *cb = NULL;
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb && cb->ghes && cb->callback)
+			cb->callback(ev_data->event_num, cb->ghes, regs);
+	}
+
+	return 0;
+}
+
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb)
+{
+	struct sse_ghes_event_data *ev_data, *evd;
+	struct sse_ghes_callback *cb;
+	u32 ev_num;
+	int err;
+
+	if (!sse_available)
+		return -EOPNOTSUPP;
+	if (!ghes || !lo_cb || !hi_cb)
+		return -EINVAL;
+
+	ev_num = ghes->generic->notify.vector;
+
+	ev_data = NULL;
+	spin_lock(&sse_ghes_event_list_lock);
+	list_for_each_entry(evd, &sse_ghes_event_list, head) {
+		if (evd->event_num == ev_num) {
+			ev_data = evd;
+			break;
+		}
+	}
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	if (!ev_data) {
+		ev_data = kzalloc(sizeof(*ev_data), GFP_KERNEL);
+		if (!ev_data)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&ev_data->head);
+		ev_data->event_num = ev_num;
+
+		INIT_LIST_HEAD(&ev_data->callback_list);
+
+		ev_data->event = sse_event_register(ev_num, ev_num,
+						    sse_ghes_handler, ev_data);
+		if (IS_ERR(ev_data->event)) {
+			pr_err("%s: Couldn't register event 0x%x\n", __func__, ev_num);
+			kfree(ev_data);
+			return -ENOMEM;
+		}
+
+		err = sse_event_enable(ev_data->event);
+		if (err) {
+			pr_err("%s: Couldn't enable event 0x%x\n", __func__, ev_num);
+			sse_event_unregister(ev_data->event);
+			kfree(ev_data);
+			return err;
+		}
+
+		spin_lock(&sse_ghes_event_list_lock);
+		list_add_tail(&ev_data->head, &sse_ghes_event_list);
+		spin_unlock(&sse_ghes_event_list_lock);
+	}
+
+	list_for_each_entry(cb, &ev_data->callback_list, head) {
+		if (cb->ghes == ghes)
+			return -EALREADY;
+	}
+
+	cb = kzalloc(sizeof(*cb), GFP_KERNEL);
+	if (!cb)
+		return -ENOMEM;
+	INIT_LIST_HEAD(&cb->head);
+	cb->ghes = ghes;
+	cb->callback = lo_cb;
+	list_add_tail(&cb->head, &ev_data->callback_list);
+
+	return 0;
+}
+
+int sse_unregister_ghes(struct ghes *ghes)
+{
+	struct sse_ghes_event_data *ev_data, *tmp;
+	struct sse_ghes_callback *cb;
+	int free_ev_data = 0;
+
+	if (!ghes)
+		return -EINVAL;
+
+	spin_lock(&sse_ghes_event_list_lock);
+
+	list_for_each_entry_safe(ev_data, tmp, &sse_ghes_event_list, head) {
+		list_for_each_entry(cb, &ev_data->callback_list, head) {
+			if (cb->ghes != ghes)
+				continue;
+
+			list_del(&cb->head);
+			kfree(cb);
+			break;
+		}
+
+		if (list_empty(&ev_data->callback_list))
+			free_ev_data = 1;
+
+		if (free_ev_data) {
+			spin_unlock(&sse_ghes_event_list_lock);
+
+			sse_event_disable(ev_data->event);
+			sse_event_unregister(ev_data->event);
+			ev_data->event = NULL;
+
+			spin_lock(&sse_ghes_event_list_lock);
+
+			list_del(&ev_data->head);
+			kfree(ev_data);
+		}
+	}
+
+	spin_unlock(&sse_ghes_event_list_lock);
+
+	return 0;
+}
diff --git a/include/linux/riscv_sbi_sse.h b/include/linux/riscv_sbi_sse.h
index 84165cb5f2d0..be0c9ad0a00c 100644
--- a/include/linux/riscv_sbi_sse.h
+++ b/include/linux/riscv_sbi_sse.h
@@ -11,6 +11,7 @@
 
 struct sse_event;
 struct pt_regs;
+struct ghes;
 
 typedef int (sse_event_handler_fn)(u32 event_num, void *arg,
 				   struct pt_regs *regs);
@@ -24,6 +25,10 @@ void sse_event_unregister(struct sse_event *evt);
 
 int sse_event_set_target_cpu(struct sse_event *sse_evt, unsigned int cpu);
 
+int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+		      sse_event_handler_fn *hi_cb);
+int sse_unregister_ghes(struct ghes *ghes);
+
 int sse_event_enable(struct sse_event *sse_evt);
 
 void sse_event_disable(struct sse_event *sse_evt);
@@ -47,6 +52,17 @@ static inline int sse_event_set_target_cpu(struct sse_event *sse_evt,
 	return -EOPNOTSUPP;
 }
 
+static inline int sse_register_ghes(struct ghes *ghes, sse_event_handler_fn *lo_cb,
+				    sse_event_handler_fn *hi_cb)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int sse_unregister_ghes(struct ghes *ghes)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int sse_event_enable(struct sse_event *sse_evt)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


